//
//  ContentView.swift
//  SampleError
//
//  Created by sakiyamaK on 2025/05/23.
//

import SwiftUI

struct ContentView: View {

    @State private var error: SampleError?

    var body: some View {
        Button("エラーが起きるかな？？") {
            do {

                try someFunction()

                try someFunction2()

            } catch let e {
                if let error = e as? SampleError {
                    self.error = error
                }
            }
        }
        .alert(item: $error, content: { sampleError in
            Alert(
                title: Text(sampleError.message),
                message: Text("ほげほげしてください"),
                dismissButton: .default(Text("OK"))
            )        })
    }

    func someFunction() throws {
        if Int.random(in: 0...1) == 0 {
            throw SampleError(message: "エラーが出たよ")
        }
    }

    func someFunction2() throws {
        if Int.random(in: 0...1) == 0 {
            throw SampleError(message: "エラー2が出たよ")
        }
        if Int.random(in: 0...1) == 0 {
            throw SampleError2(errorNo: 0)
        }
    }

}

#Preview {
    ContentView()
}
