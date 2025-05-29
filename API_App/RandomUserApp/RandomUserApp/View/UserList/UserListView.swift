//
//  ContentView.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import SwiftUI

struct UserListView: View {

    @State private var viewModel = UserListViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // MARK: - ユーザー検索条件ビュー
                    UserSearchCriteriaView(viewModel: viewModel)
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                        .padding(.horizontal)

                    // MARK: - 状態表示エリア
                    if viewModel.isLoading {
                        ProgressView("ユーザーを検索中...")
                            .padding()
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else if viewModel.users.isEmpty {
                        Text("検索条件を指定して「ユーザーを検索」ボタンを押してください。")
                            .foregroundColor(.secondary)
                            .padding()
                    }

                    // MARK: - ユーザーリスト
                    LazyVStack(spacing: 15) { // カード間のスペース
                        ForEach(viewModel.users) { user in
                            UserCard(user: user) // 新しいカードビュー
                        }
                    }
                    .padding(.horizontal) // リスト全体にも左右余白
                }
                .padding(.vertical) // ScrollView内のVStack全体に上下パディング
            }
            .navigationTitle("Random Users")
            .navigationBarTitleDisplayMode(.large) // 大きなタイトル
            .background(Color.gray.opacity(0.1).ignoresSafeArea()) // 背景色を薄くして、カードを浮き立たせる
        }
    }
}

#Preview {
    UserListView()
}
