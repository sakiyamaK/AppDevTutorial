import SwiftUI
import AVFoundation

struct MeetingView: View {
    
    @Environment(\.modelContext) private var context
    let scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    /*
      **** 解説 ****

     エラーが発生した時用のパラメータを追加
     エラーが発生しないこともあるのでoptional

     ただし、この画面でエラー画面を表示させるわけではなく
     この画面を呼び出したDetailView側に戻ってからエラーを表示させたいので
     ここではBindingで外と繋ぐ
     */
    @Binding var errorWrapper: ErrorWrapper?

    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)

            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)

                Spacer()

                Circle()
                    .stroke(lineWidth: 24)
                    .padding()

                Spacer()

                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            startScrum()
        }
        .onDisappear {
            do {
                try endScrum()
            } catch let error {
                errorWrapper = ErrorWrapper(error: error, guidance: "Meeting time was not recorded. Try again later.")

            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    private func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        scrumTimer.startScrum()
    }

    /*
      **** 解説 ****

     throwsで関数内でエラーが発生したことを外部に知らせる
     */

    private func endScrum() throws {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history = [newHistory] + scrum.history
        try context.save()
    }
}

#Preview {
    let scrum = DailyScrum.sampleData[0]
    /*
      **** 解説 ****

     パラメータを増やしたのでPreview側も修正しないといけないので注意
     */
    MeetingView(scrum: scrum, errorWrapper: .constant(nil))
}
