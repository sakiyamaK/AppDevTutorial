//
//  RandomUserResponse.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import Foundation

// APIレスポンス全体の構造
struct RandomUserResponse: Codable {
    let results: [User]
}
