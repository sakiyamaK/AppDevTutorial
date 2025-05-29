//
//  ContentView.swift
//  SampleError
//
//  Created by sakiyamaK on 2025/05/23.
//

import SwiftUI

struct ContentView: View {

    @State private var sampleError: SampleError?

    var body: some View {
        Button("エラーが起きるかな？？") {
            do {
                try someFunction()
            } catch let e {
                if let _sampleError = e as? SampleError {
                    sampleError = _sampleError
                }
            }
        }
        .alert(item: $sampleError, content: { sampleError in
            Alert(
                title: Text(sampleError.message),
                message: nil,
                dismissButton: .default(Text("OK"))
            )
        })
    }

    func someFunction() throws {
        if Int.random(in: 0...1) == 0 {
            throw SampleError(message: "エラーが出たよ")
        }
    }
}

#Preview {
    ContentView()
}
