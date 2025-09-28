//
//  ContentView.swift
//  CustomLayout
//
//  Created by sakiyamaK on 2025/09/28.
//

import SwiftUI

struct ContentView: View {

    var body: some View {

        VStack {

            Text("文字の長さに関わらず\nボタンの幅を揃えたい")
                .font(.title)
                .bold()
                .padding(.bottom, 20)

            VStack(spacing: 60) {
                Text("文字数に応じてボタン幅も決まってしまう")
                    .font(.headline)

                VStack {
                    Button(action: {
                        print("tap")
                    }, label: {
                        Text("短いタイトル")
                    })
                    .buttonStyle(.borderedProminent)

                    Button(action: {
                        print("tap")
                    }, label: {
                        Text("長いタイトル長いタイトル")
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 1)
            )

            Spacer()

            VStack(spacing: 60) {
                Text("文字の幅をinfinityにすると画面端まで伸びてしまう")
                    .font(.headline)

                VStack {
                    Button(action: {
                        print("tap")
                    }, label: {
                        Text("短いタイトル")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)

                    Button(action: {
                        print("tap")
                    }, label: {
                        Text("長いタイトル長いタイトル")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 1)
            )

            Spacer()

            VStack(spacing: 60) {
                // カスタムレイアウトが入ることでTextのレイアウトの優先度が下がることがある
                // そのため明示的にfixedSizeを指定しないと2行にならなかったりする
                Text("最も長いコンテンツに合わせるために専用のレイアウトを作る")
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)

                MyEqualWidthVStack {
                    Button(action: {
                        print("tap")
                    }, label: {
                        Text("短いタイトル")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)

                    Button(action: {
                        print("tap")
                    }, label: {
                        Text("長いタイトル長いタイトル")
                            .frame(maxWidth: .infinity)
                    })
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.blue, lineWidth: 1)
            )

            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
