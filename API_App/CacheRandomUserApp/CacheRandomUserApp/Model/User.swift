//
//  User.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import Foundation

struct User: Codable, Identifiable {
    var id: ID
    let gender: String
    let name: Name
    let email: String
    let picture: Picture
    let nat: String // 国籍

    // 入れ子のjsonをstructでさらに定義

    // IDはUserのIdentifiableとしても使うので、Hashableも必要となる
    struct ID: Codable, Hashable {
        let name: String?
        let value: String?

        var isNotEmpty: Bool {
            guard let name, let value else { return false }
            return !name.isEmpty && !value.isEmpty
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(value)
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

    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
}
