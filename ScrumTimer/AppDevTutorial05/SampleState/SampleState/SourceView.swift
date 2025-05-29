//
//  ContentView.swift
//  SampleState
//
//  Created by sakiyamaK on 2025/05/15.
//

import SwiftUI

struct User {
    var name: String
    var age: Int
    var isActive: Bool
}

struct SourceView: View {

    @State var sourceValue: Int = 0

    var body: some View {
        VStack(spacing: 10) {
            Button("+1するよ") {
                sourceValue += 1
            }
            Text("Source Value \(sourceValue)")

            CopyView(copyValue: sourceValue)

            BindingView(bindingValue: $sourceValue)
        }
    }
}

struct CopyView: View {

    @State var copyValue: Int = 0

    var body: some View {
        Text("Copy Value \(copyValue)")
    }
}

struct BindingView: View {

    @Binding var bindingValue: Int

    var body: some View {
        Text("Binding Value \(bindingValue)")
    }
}


#Preview {
    SourceView()
}
