import SwiftUI

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
