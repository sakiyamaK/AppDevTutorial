//
//  PracticeClosureView.swift
//  ikenie_ios
//
//  Created by 塩見陵介 on 2025/06/04.
//

import SwiftUI

struct PracticeClosureView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("PracticeClosureView")
            
            /// ここでボタンをタップしたとき、以下を出力する
            ///
            ///  "適当ボタンが押されました"
            CustomButton(title: "適当", backgroundColor: Color.blue)
        }
        
        
    }
}

struct CustomButton: View {
    let title: String
    let backgroundColor: Color
    
    var body: some View {
        Button(title) {
            // ここで外部から渡されたクロージャーを実行したい
        }
        .padding()
        .background(backgroundColor)
        .foregroundColor(.white)
        .cornerRadius(8)
    }
}

#Preview {
    PracticeClosureView()
}
