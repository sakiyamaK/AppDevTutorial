//
//  SampleEnvironmentApp.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/03/29.
//

import SwiftUI

@main
struct SampleEnvironmentApp: App {
    var body: some Scene {
        WindowGroup {
            ThemeSettingsEnvironmentView1()
                .environment(\.themeSettings, .init())
        }
    }
}
