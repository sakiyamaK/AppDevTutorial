//
//  UserRow.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import SwiftUI

struct UserCard: View {
    let user: User
    @State private var isPressed = false

    var body: some View {
        HStack(spacing: 15) {
            // プロフィール画像
            AsyncImage(url: URL(string: user.picture.large)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        colors: [.blue.opacity(0.5), .purple.opacity(0.5)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                } else if phase.error != nil {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray.opacity(0.5))
                } else {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
            }

            // ユーザー情報
            VStack(alignment: .leading, spacing: 6) {
                Text(user.name.full)
                    .font(.title3)
                    .fontWeight(.semibold)

                Text(user.email)
                    .font(.footnote)

                HStack(spacing: 4) {
                    Image(systemName: "flag.fill")
                        .font(.caption)
                    Text(user.nat.uppercased())
                        .font(.caption)
                }
            }

            Spacer()

            // 詳細ボタン
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .onTapGesture {
            withAnimation {
                isPressed = true
                Task { @MainActor in
                    try await Task.sleep(nanoseconds: 100_000_000)
                    isPressed = false
                }
            }
        }
    }
}

//#Preview {
//    ZStack {
//        Color.white.ignoresSafeArea()
//        UserCard(user: User(
//            id: User.ID(name: "test", value: "12345"),
//            gender: "male",
//            name: User.Name(title: "Mr", first: "John", last: "Doe"),
//            email: "john.doe@example.com",
//            phone: "123-456-7890",
//            cell: "098-765-4321",
//            picture: User.Picture(
//                large: "https://randomuser.me/api/portraits/men/1.jpg",
//                medium: "https://randomuser.me/api/portraits/med/men/1.jpg",
//                thumbnail: "https://randomuser.me/api/portraits/thumb/men/1.jpg"
//            ),
//            nat: "US"
//        ))
//        .padding()
//    }
//}
