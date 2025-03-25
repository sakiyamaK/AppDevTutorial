import SwiftUI
/*
 ********** 解説 **********
 AVPlayerなど音や映像を出す処理はAVFoundationフレームワークに属する
*/

import AVFoundation

struct MeetingView: View {

    /*
     ********** 解説 **********
     追記
    */
    @Binding var scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    var body: some View {
        /*
         ********** 解説 **********
         zStackは下からどんどん重ねていく
        */
        ZStack {
            /*
             ********** 解説 **********
             背景色を付けるためだけに用意した？
            */
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)

            VStack {
                /*
                 ********** 解説 **********
                 structが巨大になってきたので分けた
                */
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
             onAppearは画面が呼ばれた時に処理される
            */

            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear {
            /*
             ********** 解説 **********
             onDisappearは画面が消える時に処理される

            */
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {

    /*
     ********** 解説 **********
     Binding.constant(値)で一定値を監視し続ける
     こうやって動作確認したい時用
    */
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
