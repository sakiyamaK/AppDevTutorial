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


//struct CopyView: View {
//    var copyValue: Int
//
//    var body: some View {
//        Text("Copy: \(copyValue)")
//    }
//}
//
//struct SourceView: View {
//    var sourceValue: Int = 1
//
//    var body: some View {
//        VStack {
//            Text("Body: \(sourceValue)")
//            CopyView(copyValue: sourceValue)
//            Button("値を変更") {
//                sourceValue = 2
//            }
//        }
//    }
//}

struct CopyView: View {
    @Binding var copyValue: Int

    var body: some View {
        Text("Copy: \(copyValue)")
    }
}

struct SourceView: View {
    @State var sourceValue: Int = 1

    var body: some View {
        VStack {
            Text("Body: \(sourceValue)")
            CopyView(copyValue: $sourceValue)
            Button("値を変更") {
                sourceValue = 2
            }
        }
    }
}

#Preview(body: {
    SourceView()
})
