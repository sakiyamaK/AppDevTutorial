//
//  AppDevTutorial08App.swift
//  AppDevTutorial08
//
//  Created by sakiyamaK on 2025/03/17.
//

import SwiftUI
import SwiftData

/*
 解説
 アプリ起動時にState属性で取得していたscrumsパラメータをModelContainerから受け取る
 */

@main
struct AppDevTutorial08App: App {

    var body: some Scene {
        WindowGroup {
            ScrumsView()
        }
        .modelContainer(for: DailyScrum.self)
    }
}
