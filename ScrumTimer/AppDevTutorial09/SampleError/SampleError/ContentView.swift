//
//  ContentView.swift
//  SampleError
//
//  Created by sakiyamaK on 2025/05/23.
//

import SwiftUI

struct ContentView: View {

    var id: Int
    @State private var error: ErrorWrapper?

    var body: some View {
        Button("エラーが起きるかな？？") {
            do {

                try someFunction()

                try someFunction2()

            } catch let e {
                self.error = ErrorWrapper(error: e)
            }
        }
        .alert(item: $error, content: { errorWrapper in
            if let sampleError = errorWrapper.error as? SampleError {
                Alert(
                    title: Text(sampleError.message),
                    message: Text("ほげほげしてください"),
                    dismissButton: .default(Text("OK"))
                )
            } else if let sampleError2 = errorWrapper.error as? SampleError2 {
                Alert(
                    title: Text(sampleError2.errorNo.description),
                    message: nil,
                    dismissButton: .default(Text("OK"))
                )
            } else {
                Alert(
                    title: Text("謎のエラー"),
                    message: nil,
                    dismissButton: .default(Text("OK"))
                )
            }
        })
    }

    func someFunction() throws {
        if Int.random(in: 0...1) == 0 {
            throw SampleError(
                message: "エラーが出たよ"
            )
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
