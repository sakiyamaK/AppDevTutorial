//
//  GlobalParameterView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/03/29.
//

import SwiftUI

/*
 ********** 解説 **********

 StringEnvironmentView.swiftの事例だけだとこのようにグローバル変数でも良いように思えてしまう
 グローバル変数はあらゆる事例においてほぼ最終手段と思って使わないように

 どこからもアクセスできる = 修正した場合どこに影響するか分からない

 プロジェクトが5000ファイルあったら、グローバル変数をひとつ変えると5000ファイルに影響がないか確認がいる

 TabEnvironmentView.swiftで環境変数だと影響範囲をコントロールできる事例を示す
 */

var globalValue: String = "Default Value"

struct GlobalParameterView1: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("\(globalValue)")
            NavigationLink(destination: GlobalParameterView2()) {
                Text("Next Screen")
            }
        }
        .navigationTitle(Text("GlobalParameterView1"))
    }
}

struct GlobalParameterView2: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("\(globalValue)")
        }
        .navigationTitle(Text("GlobalParameterView2"))
    }
}

#Preview {

    globalValue = "Update Global!"

    return NavigationView {
        GlobalParameterView1()
    }
}
