//
//  AppDevTutorial09App.swift
//  AppDevTutorial09
//
//  Created by sakiyamaK on 2025/03/17.
//

import SwiftUI
import SwiftData

@main
struct AppDevTutorial09App: App {

    var body: some Scene {
        WindowGroup {
            ScrumsView()
        }
        .modelContainer(for: DailyScrum.self)
    }
}
