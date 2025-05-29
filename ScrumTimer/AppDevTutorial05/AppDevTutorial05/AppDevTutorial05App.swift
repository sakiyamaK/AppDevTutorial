//
//  AppDevTutorial05App.swift
//  AppDevTutorial05
//
//  Created by sakiyamaK on 2025/03/16.
//

import SwiftUI

@main
struct AppDevTutorial05App: App {
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: DailyScrum.sampleData)
        }
    }
}
