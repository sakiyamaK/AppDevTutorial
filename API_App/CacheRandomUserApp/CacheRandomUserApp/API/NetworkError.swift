//
//  NetworkError.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "無効なURLです。"
        case .invalidResponse:
            "サーバーからの無効なレスポンスです。"
        case .decodingError(let error):
            "データのデコードに失敗しました: \(error.localizedDescription)"
        case .unknown(let error):
            "不明なエラーが発生しました: \(error.localizedDescription)"
        }
    }
}
