//
//  AppDevTutorial03App.swift
//  AppDevTutorial03
//
//  Created by sakiyamaK on 2025/03/15.
//

import SwiftUI

@main
struct AppDevTutorial03App: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
