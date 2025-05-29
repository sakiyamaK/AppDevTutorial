//
//  ContentView.swift
//  AppDevTutorial01
//
//  Created by sakiyamaK on 2025/03/15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        VStack {
            ProgressView(value: 5, total: 15)
                .background(Color.gray)

            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    /*
                      *********** 解説 **********
                     systemImageは組み込まれたアイコン
                     SFsymbolsにあるものが使える
                     ただし起動させるOSのバージョン次第では使えない物あるので注意
                     https://developer.apple.com/jp/sf-symbols/
                     */
                    Label("300", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }


            /*
              ********** 解説 **********

             公式ではこうなってる

             background(.blue)
             と付ければ分かるがstrokeBorderをすると全体の領域が変わる
             分かりづらい気がする...

             strokeと
             strokeBorderを

             cmd + click で定義ジャンプすると分かるが

             strokeは Shape の拡張
             strokeBorderは InsettableShape の拡張

             InsettableShapeが何のために用意されてるのかよく分からない...

             */
//            Circle()
//                .strokeBorder(lineWidth: 24)

            Group {
                Spacer()

                Circle()
                    .stroke(lineWidth: 24)
                    .padding()

                Spacer()
            }

            HStack {
                Text("Speaker 1 of 3")
                Spacer()

                Button(action: {
                    print("tap")
                }) {
                    Image(systemName: "forward.fill")
                }
            }
        }
        .padding()
    }
}

// 書き方がシンプルになった
#Preview {
    ContentView()
}
