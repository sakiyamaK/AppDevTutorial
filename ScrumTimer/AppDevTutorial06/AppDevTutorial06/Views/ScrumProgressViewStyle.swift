import SwiftUI

/*
 ********** 解説 **********
 ProgressViewのレイアウトはProgressViewStyleに準拠したstructを渡すことで変えられる
*/
struct ScrumProgressViewStyle: ProgressViewStyle {
    var theme: Theme

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(theme.accentColor)
                .frame(height: 20.0)

            ProgressView(configuration)
                .tint(theme.mainColor)
                .frame(height: 12.0)
                .padding(.horizontal)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ProgressView(value: 0.4)
        .progressViewStyle(ScrumProgressViewStyle(theme: .buttercup))
}


/*
 ********** 補足の解説 **********
 今回の例だと別にScrumProgressViewStyleを用意しなくても
 他のコンポーネントと同じようにこうしてViewを増やせば良いと思う

 そうしなかったのはProgressViewには自前のスタイルを適応できるってことを
 Appleが伝えたかったんだと思う
*/

struct ScrumProgressView: View {
    var value: Double
    var theme: Theme

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(theme.accentColor)
                .frame(height: 20.0)
            ProgressView(value: value)
                .tint(theme.mainColor)
                .frame(height: 12.0)
                .padding(.horizontal)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ScrumProgressView(value: 0.4, theme: .buttercup)
}
