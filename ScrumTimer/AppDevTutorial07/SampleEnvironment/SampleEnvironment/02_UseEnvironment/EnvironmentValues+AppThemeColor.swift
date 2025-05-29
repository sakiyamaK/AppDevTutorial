//
//  EnvironmentValues+.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI
/*
 ********** 解説 **********
 自前で環境変数を用意する場合

 1. EnvironmentKeyに準拠した自分用のKeyを用意して
 2. EnvironmentValuesを拡張して呼び出す
 */

// 1. カスタムEnvironmentキーの定義
struct AppThemeColorEnvironmentKey: EnvironmentKey {
    /*
     ********** 解説 **********
     ここの値が初期値
     もちろんColor以外にもstructやenumやclassでもいける
     */
    static let defaultValue: Color = .blue
}

// 2. EnvironmentValuesを拡張
extension EnvironmentValues {
    var appThemeColor: Color {
        get {
            self[AppThemeColorEnvironmentKey.self]
        }
        set {
            self[AppThemeColorEnvironmentKey.self] = newValue
        }
    }
}
