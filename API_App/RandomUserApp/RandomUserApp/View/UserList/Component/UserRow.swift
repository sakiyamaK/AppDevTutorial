//
//  UserRow.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import SwiftUI

struct UserRow: View {
    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: user.picture.thumbnail)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                } else if phase.error != nil {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.gray)
                } else {
                    ProgressView()
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.trailing, 8)

            VStack(alignment: .leading) {
                Text(user.name.full)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("国籍: \(user.nat.uppercased())")
                    .font(.caption)
                    .foregroundColor(.teal)
            }
            Spacer()
        }
        .padding(.vertical, 4)
        .background(Color.white)
    }
}

struct UserCard: View {
    let user: User

    var body: some View {
        HStack(spacing: 15) {
            AsyncImage(url: URL(string: user.picture.large)) { phase in // large 画像を使用
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill() // Fillにして、切り取る
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } else if phase.error != nil {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                } else {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
            }
            // 画像の右側に少し余白
            .padding(.trailing, 5)

            VStack(alignment: .leading, spacing: 4) {
                Text(user.name.full)
                    .font(.title3) // フォントサイズを少し大きく
                    .fontWeight(.semibold) // 少し太字に
                    .foregroundColor(.primary)

                Text(user.email)
                    .font(.footnote) // メールアドレスは小さく
                    .foregroundColor(.secondary)

                HStack {
                    Image(systemName: "flag.fill") // 国旗アイコン
                        .font(.caption)
                    Text(user.nat.uppercased())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 2) // 少し上からのパディング
            }
            Spacer()
        }
        .padding(15) // カード全体にパディング
        .background(Color.white) // カードの背景色
        .cornerRadius(15) // カードの角丸
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 3) // カードのシャドウ
    }
}
