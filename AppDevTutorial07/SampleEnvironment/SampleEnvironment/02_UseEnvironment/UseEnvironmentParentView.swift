//
//  NoUseEnvironmentParentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//
import SwiftUI

struct UseEnvironmentParentView: View {

    /*
     ********** 解説 **********
     バケツリレーが消えた！！！！！
     */

    var body: some View {
        VStack {
            Text("中間のビュー")
                .font(.title)
            UseEnvironmentChildView()
        }
        .padding()
        .border(Color.green, width: 2)
    }
}
