//
//  TabEnvironmentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/03/29.
//

import SwiftUI

/*
 ********** 解説 **********

 Tabごとにenvironmentを設定できる
 影響範囲もそのタブ内だけですむ
 グローバル変数だとこれが全体に影響を及ぼす
 */

struct TabEnvironmentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                ThemeSettingsEnvironmentView1()
            }
            .tabItem {
                Image(systemName: "1.circle")
                Text("First")
            }
            .environment(\.themeSettings, .init())

            NavigationStack {
                ThemeSettingsEnvironmentView1()
            }
            .tabItem {
                Image(systemName: "2.circle")
                Text("Second")
            }
            .environment(\.themeSettings, .init(fontSize: 10, accentColor: .red))

            NavigationStack {
                ThemeSettingsEnvironmentView1()
            }
            .tabItem {
                Image(systemName: "3.circle")
                Text("Third")
            }
            .environment(\.themeSettings, .init(fontSize: 30, accentColor: .blue))
        }
    }
}


#Preview {
    TabEnvironmentView()
}
