//
//  NoUseEnvironemntContentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI

struct NoUseEnvironemntContentView: View {
    @State var appThemeColor: Color = .blue

    var body: some View {
        VStack(spacing: 20) {
            Button("色の切り替え") {
                // 青と赤を切り替える
                appThemeColor = appThemeColor == .blue ? .red : .blue
            }
            .foregroundStyle(appThemeColor)
            .font(.title)
            // ★ 中間ビューに色を手渡しする必要がある
            NoUseEnvironmentParentView(themeColor: $appThemeColor)
        }
        .padding()
    }
}


#Preview {
    NoUseEnvironemntContentView()
}
