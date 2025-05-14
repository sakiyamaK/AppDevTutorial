//
//  NoUseEnvironmentChildView.swift
//  SampleEnvironment
//
//  Created by sakiyamaK on 2025/05/14.
//

import SwiftUI

struct NoUseEnvironmentChildView: View {
    @Binding var themeColor: Color

    var body: some View {
        Text("子ビュー")
            .font(.title)
            .padding()
            .border(Color.green, width: 2)
            .background(themeColor)
    }
}
