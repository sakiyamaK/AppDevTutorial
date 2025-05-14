//
//  NoUseEnvironemntContentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI

struct UseEnvironemntContentView: View {
    /*
     ********** 解説 **********
     Environmentの値を管理するための変数
     */
    @State private var appThemeColorValue: Color = .blue

    var body: some View {
        VStack(spacing: 20) {
            Button("色の切り替え") {
                // 青と赤を切り替える
                appThemeColorValue = appThemeColorValue == .blue ? .red : .blue
            }
            .foregroundStyle(appThemeColorValue)
            .font(.title)
            /*
             ********** 解説 **********
             Environmentに値を設定する。
             これ以降の子孫ビューはEnvironmentからアクセスできる。
             */
            UseEnvironmentParentView()
                .environment(\.appThemeColor, appThemeColorValue) // !!!ここで設定!!!!
        }
        .padding()
    }
}


#Preview {
    UseEnvironemntContentView()
}
