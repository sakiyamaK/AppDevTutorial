//
//  ThemeSettingsEnvironmentView1.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI

/*
 ********* 解説 **********

遷移先の ThemeSettingsEnvironmentView2 で環境変数が更新されると
こちらも変わっていることが確認できる
*/
struct ThemeSettingsEnvironmentView1: View {
   @Environment(\.themeSettings) var themeSettings

   var body: some View {
       VStack(spacing: 30) {
           Text("テーマカラー")
           NavigationLink(destination: ThemeSettingsEnvironmentView2()) {
               Text("Next Screen")
           }
       }
       .foregroundStyle(themeSettings.accentColor)
       .font(.system(size: themeSettings.fontSize))
       .navigationTitle(Text("EnvironmentView1"))
   }
}

#Preview {
    NavigationView {
        ThemeSettingsEnvironmentView1()
    }
    .environment(\.themeSettings, .init())
}
