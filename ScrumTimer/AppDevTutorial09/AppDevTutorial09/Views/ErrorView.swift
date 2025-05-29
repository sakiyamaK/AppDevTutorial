//
//  ErrorView.swift
//  AppDevTutorial09
//
//  Created by sakiyamaK on 2025/04/13.
//

import SwiftUI

/*
  **** 解説 ****

 新規に追加したView

 特に難しいこともなくエラー用のモデルを受け取って表示する
 */

struct ErrorView: View {
    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

/*
  **** 解説 ****

 プレビュー用のエラーを用意してる
 本当はこういう開発時にしか使わないものはリリース時には含ませたくない
 マクロで分けたりビルド設定でリリース時だけ含ませないとかやるがここでは省略
 */

private enum SampleError: Error {
    case errorRequired
}

#Preview {
    ErrorView(errorWrapper: ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this error."))
}
