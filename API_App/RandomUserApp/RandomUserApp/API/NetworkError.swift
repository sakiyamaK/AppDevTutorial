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
            return "無効なURLです。"
        case .invalidResponse:
            return "サーバーからの無効なレスポンスです。"
        case .decodingError(let error):
            return "データのデコードに失敗しました: \(error.localizedDescription)"
        case .unknown(let error):
            return "不明なエラーが発生しました: \(error.localizedDescription)"
        }
    }
}
