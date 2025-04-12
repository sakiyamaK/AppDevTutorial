//
//  AppDevTutorial08App.swift
//  AppDevTutorial08
//
//  Created by sakiyamaK on 2025/03/17.
//

import SwiftUI
import SwiftData

/*
 ********** 解説 **********

 WindowGroup全体にmodelContainerを指定することで、
 アプリ起動時にSwiftDataで管理するModelを指定する
 パラメータ次第では保存先をハードディスクではなくメモリに限定もできる

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
