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
                VStack(spacing: 24) {
                    // ユーザー検索条件ビュー
                    UserSearchCriteriaView(viewModel: viewModel)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal)

                    // 状態表示エリア
                    if viewModel.isLoading {
                        VStack(spacing: 12) {
                            ProgressView()
                                .scaleEffect(1.2)
                            Text("ユーザーを検索中...")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .cornerRadius(16)
                            .padding(.horizontal)
                    } else if viewModel.users.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 40))
                                .foregroundColor(.white.opacity(0.6))
                            Text("検索条件を指定して「ユーザーを検索」ボタンを押してください。")
                                .foregroundColor(.white.opacity(0.6))
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    }

                    if !viewModel.isLoading {
                        // LazyVStack
                        // 内部のViewたちのインスタンスを即座に生成せず画面に映るタイミングでインスタンスを生成する
                        // 負荷軽減のためにやる
                        // Lazyは「今は定義だけするけど実行は後からやるよ」って意味
                        // 他にもLazyXXとか lazy var とかを見かけることはあるけど同じ意味
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.users) { user in
                                UserCard(user: user)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Random Users")
        .navigationBarTitleDisplayMode(.large)
    }
}


#Preview {
    UserListView()
}
