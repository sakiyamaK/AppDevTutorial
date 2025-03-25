import SwiftUI
import AVFoundation

struct MeetingView: View {

    @Binding var scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
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
            /*
             ********** 解説 **********

             リファクタ機能でやってみよう！
             ここに書いていたソースを複数行選択して右クリック
             Refactor > Extract Method
             そして名前を決めると勝手に選択部分を抜き出した関数ができる

             ...だけどこんな機能使ったことないw
             */

            startScrum()
        }
        .onDisappear {

            endScrum()
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

    private func endScrum() {
        scrumTimer.stopScrum()
        /*
         ********** 解説 **********

         新しい記録のインスタンスを生成して配列の先頭に追加

         insertでもいいよ
         */
        let newHistory = History(attendees: scrum.attendees)
        //            scrum.history.insert(newHistory, at: 0)
        scrum.history = [newHistory] + scrum.history
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
