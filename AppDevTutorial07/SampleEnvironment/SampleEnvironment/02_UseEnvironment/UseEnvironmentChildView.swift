//
//  NoUseEnvironmentChildView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI

struct UseEnvironmentChildView: View {
    /*
     ********** 解説 **********

     この環境変数をこの名前で使うよと指定する
     この\.はキーパス式という書き方
     https://qiita.com/imchino/items/67a987681bca5ad0408b
     EnvironmentValuesのappThemeColorの参照値だよという意味
     */
    @Environment(\.appThemeColor) var appThemeColor

    var body: some View {
        Text("子ビュー")
            .font(.title)
            .padding()
            .border(Color.green, width: 2)
            .background(appThemeColor)
    }
}
