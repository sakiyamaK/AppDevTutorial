//
//  UpdateEnvironmentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/03/29.
//

import SwiftUI

struct ThemeSettingsEnvironmentView2: View {
    @Environment(\.themeSettings) var themeSettings

    var body: some View {
        VStack(spacing: 30) {
            Text("テーマカラー")
            Button(action: {
                /*
                 ********** 解説 **********
                 クラスで定義されたメソッドを呼ぶ
                 つまりthemeSettings自体に新しい何かが代入されているわけではないからエラーも起きない
                 */
                themeSettings.toggleAccentColor()
            }) {
                Text("テーマカラーを切り替え")
            }
            Button(action: {
                themeSettings.updateFontSize()
            }) {
                Text("フォントサイズをあげる")
            }
        }
        .foregroundStyle(themeSettings.accentColor)
        .font(.system(size: themeSettings.fontSize))
        .navigationTitle(Text("EnvironmentView2"))
    }
}
