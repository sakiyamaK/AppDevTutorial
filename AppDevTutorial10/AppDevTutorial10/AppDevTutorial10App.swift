//
//  AppDevTutorial10App.swift
//  AppDevTutorial10
//
//  Created by sakiyamaK on 2025/03/17.
//

import SwiftUI
import SwiftData

@main
struct AppDevTutorial10App: App {

    var body: some Scene {
        WindowGroup {
            ScrumsView()
        }
        .modelContainer(for: DailyScrum.self)
    }
}
