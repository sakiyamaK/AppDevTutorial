//
//  h.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI

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
