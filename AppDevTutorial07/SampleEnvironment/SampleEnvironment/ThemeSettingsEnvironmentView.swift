//
//  UpdateEnvironmentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/03/29.
//

import SwiftUI
import Observation

/*
 ********** 解説 **********
 自前で「更新可能」な環境変数を用意する場合
iOS17から使えるObservationを使う場合

 1. 更新させるデータ構造を用意して
 2. EnvironmentKeyに準拠した自分用のKeyを用意して
 3. EnvironmentValuesを拡張して呼び出す
 */

// 1. 更新させるデータ構造を用意して
@Observable
class ThemeSettings {
    /*
     ********** 解説 **********
     setだけprivate
     つまり外からアクセスできるが更新はできない
     */
    private(set) var fontSize: CGFloat
    private(set) var accentColor: Color

    func toggleAccentColor() {
        accentColor = accentColor == .blue ? .red : .blue
    }

    func updateFontSize() {
        fontSize += 5
    }

    init(fontSize: CGFloat = 18, accentColor: Color = .blue) {
        self.fontSize = fontSize
        self.accentColor = accentColor
    }
}

// 2. EnvironmentKeyに準拠した自分用のKeyを用意して
struct ThemeSettingsKey: EnvironmentKey {
    static let defaultValue: ThemeSettings = .init()
}

// 3. EnvironmentValuesを拡張して呼び出す
extension EnvironmentValues {
    var themeSettings: ThemeSettings {
        get {
            self[ThemeSettingsKey.self]
        }
        set {
            self[ThemeSettingsKey.self] = newValue
        }
    }
}

/*
 ********** 解説 **********

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

#Preview {
    NavigationView {
        ThemeSettingsEnvironmentView1()
    }
    .environment(\.themeSettings, .init())
}
