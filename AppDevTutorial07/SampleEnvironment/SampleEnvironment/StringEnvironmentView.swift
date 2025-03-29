//
//  ContentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/03/29.
//

import SwiftUI

/*
 ********** 解説 **********
 自前で環境変数を用意する場合

 1. EnvironmentKeyに準拠した自分用のKeyを用意して
 2. EnvironmentValuesを拡張して呼び出す
 */

// 1. カスタムEnvironmentキーの定義
struct CustomStringEnvironmentKey: EnvironmentKey {
    /*
     ********** 解説 **********
     ここの値が初期値
     もちろんString以外にもstructやenumやclassでもいける
     */
    static let defaultValue: String = "Default Value"
}

// 2. EnvironmentValuesを拡張
extension EnvironmentValues {
    var customStringValue: String {
        get {
            self[CustomStringEnvironmentKey.self]
        }
        set {
            self[CustomStringEnvironmentKey.self] = newValue
        }
    }
}

struct StringEnvironmentView1: View {
    /*
     ********** 解説 **********

     この環境変数をこの名前で使うよと指定する
     この\.はキーパス式という書き方
     https://qiita.com/imchino/items/67a987681bca5ad0408b
     EnvironmentValuesのcustomStringValueの参照値だよという意味
     */
    @Environment(\.customStringValue) var customString

    var body: some View {
        VStack(spacing: 30) {
            Text("\(customString)")
            NavigationLink(destination: StringEnvironmentView2()) {
                Text("Next Screen")
            }
        }
        .navigationTitle(Text("EnvironmentView1"))
    }
}

struct StringEnvironmentView2: View {
    @Environment(\.customStringValue) var customString

    var body: some View {
        VStack(spacing: 30) {
            /*
             ********** 解説 **********

             初期値のDefault Valueではなく
             全体で設定したHello, Environment!が代入されている
             */

            Text("\(customString)")
        }
        .navigationTitle(Text("EnvironmentView2"))
    }
}

#Preview {
    /*
     ********** 解説 **********

     呼び出し時に初期値を変えることもできる

     !!!! 注意事項 !!!
     EnvironmentView1にenvironmentを設定するのではなく
     NavigationViewにenvironmentを設定する
     */
    NavigationView {
        StringEnvironmentView1()
    }
    .environment(\.customStringValue, "Hello, Environment!")
}
