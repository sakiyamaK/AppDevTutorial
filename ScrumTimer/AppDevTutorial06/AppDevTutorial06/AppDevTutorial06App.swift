//
//  AppDevTutorial06App.swift
//  AppDevTutorial06
//
//  Created by sakiyamaK on 2025/03/17.
//

import SwiftUI

@main
struct AppDevTutorial06App: App {

    /*
     ********** 解説 **********

     信頼できる情報源をここにする
     */

    @State private var scrums = DailyScrum.sampleData

    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
