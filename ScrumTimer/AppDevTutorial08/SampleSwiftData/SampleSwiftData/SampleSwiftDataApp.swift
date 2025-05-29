//
//  SampleSwiftDataApp.swift
//  SampleSwiftData
//
//  Created by sakiyamaK on 2025/05/21.
//

import SwiftUI
import SwiftData

@main
struct SampleSwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkCategoryListView()
            }
        }
        .modelContainer(for: [WorkCategory.self, Work.self])
    }
}
