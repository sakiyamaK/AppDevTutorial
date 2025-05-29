import SwiftUI
/*
 ********** 解説 **********
 MeetingViewがが巨大になってきたので分けた
*/
struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme

    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
            /*
             ********** 解説 **********
             ProgressViewの見た目を変更するにはproguressViewStyleに適応したらいいらしい
             デフォルトでもいくつかのスタイルが用意されている

             今回の例だと別に自前のstyleを用意する意味はなさそう...
            */
//            ProgressView(value: progress)
//                .progressViewStyle(ScrumProgressViewStyle(theme: theme))

            ScrumProgressView(value: progress, theme: theme)

            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .padding([.top, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
}
