//
//  AppDevTutorial04App.swift
//  AppDevTutorial04
//
//  Created by sakiyamaK on 2025/03/15.
//

import SwiftUI

@main
struct AppDevTutorial04App: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
