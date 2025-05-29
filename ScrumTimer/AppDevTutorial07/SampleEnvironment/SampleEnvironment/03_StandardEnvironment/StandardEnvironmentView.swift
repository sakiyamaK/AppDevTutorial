//
//  StandardEnvironmentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI

struct StandardEnvironmentView: View {

    /*
     ********** 標準Environment値の解説 **********
     アプリ側で直接これらの値を「設定」することは通常ないが、
     それらを「読み取って」UIを調整するために使用します。
     */

    // 現在のカラースキーム (ライトモード or ダークモード) を取得
    @Environment(\.colorScheme) var colorScheme

    // 現在のロケール (地域設定、言語、日付/数値フォーマットなど) を取得
    @Environment(\.locale) var locale

    var body: some View {
        VStack(spacing: 20) {

            // colorScheme の表示とそれに応じたテキスト色の変化
            Text("現在のカラースキーム: \(colorScheme == .dark ? "ダークモード" : "ライトモード")")
                .foregroundColor(colorScheme == .dark ? .cyan : .primary) // Environment値に応じて色を変更

            // locale の表示
            Text("現在のロケール: \(locale.identifier)")
        }
        .padding()
    }
}

#Preview {
    struct TabEnvironmentView: View {
        var body: some View {
            TabView {
                StandardEnvironmentView()
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("デフォルト")
                    }
                    .preferredColorScheme(.light)
                
                StandardEnvironmentView()
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("フランス")
                    }
                    .environment(\.locale, .init(identifier: "fr_FR")) // ロケールをフランス語に設定
                    .preferredColorScheme(.light)
                
            }
        }
    }
    
    return TabEnvironmentView()
            .preferredColorScheme(.dark)
}
