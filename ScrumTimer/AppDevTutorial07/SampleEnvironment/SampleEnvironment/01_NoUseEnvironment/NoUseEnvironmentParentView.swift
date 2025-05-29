//
//  NoUseEnvironmentParentView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//
import SwiftUI

struct NoUseEnvironmentParentView: View {
    @Binding var themeColor: Color

    var body: some View {
        VStack {
            Text("中間のビュー")
                .font(.title)
            NoUseEnvironmentChildView(themeColor: $themeColor)
        }
        .padding()
        .border(Color.green, width: 2)
    }
}
