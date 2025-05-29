//
//  User.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import Foundation

// ユーザー情報の構造体
struct User: Codable, Identifiable {
    var id: ID
    let gender: String
    let name: Name
    let email: String
    let phone: String
    let cell: String
    let picture: Picture
    let nat: String // 国籍

    struct ID: Codable, Hashable {
        var id: UUID = UUID()

        let name: String?
        let value: String?

        func hash(into hasher: inout Hasher) {
            id.hash(into: &hasher)
        }

        enum CodingKeys: CodingKey {
            case name
            case value
        }

        init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<User.ID.CodingKeys> = try decoder.container(keyedBy: User.ID.CodingKeys.self)
            self.id = UUID()
            self.name = try container.decodeIfPresent(String.self, forKey: User.ID.CodingKeys.name)
            self.value = try container.decodeIfPresent(String.self, forKey: User.ID.CodingKeys.value)
        }
    }

    struct Name: Codable {
        let title: String
        let first: String
        let last: String

        var full: String {
            "\(title). \(first) \(last)"
        }
    }

    // 画像URL部分の構造体
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
}
