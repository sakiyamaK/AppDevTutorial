//
//  API.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import Foundation

final class API {
    static let shared = API()

    private let host = "https://randomuser.me/api/"

    struct RequestParameter {
        let gender: String?
        let nationality: String?
        var resultsCount: Int = 10
    }

    func fetchUsers(paramter: RequestParameter) async throws -> [User] {

        let requestURL = try makeRequestURL(paramter: paramter)
        print("Fetching users from: \(requestURL.absoluteString)") // デバッグ用

        do {
            let (data, response) = try await URLSession.shared.data(from: requestURL)

//            data.printJson()

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }

            let decodedResponse = try JSONDecoder().decode(RandomUserResponse.self, from: data)
            return decodedResponse.results
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingError(decodingError)
        } catch {
            throw NetworkError.unknown(error)
        }
    }

    private func makeRequestURL(paramter: RequestParameter) throws -> URL {

        var components = URLComponents(string: host)!

        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "results", value: "\(paramter.resultsCount)")
        ]

        if let gender = paramter.gender, !gender.isEmpty {
            let queryItem = URLQueryItem(name: "gender", value: gender.lowercased())
            queryItems.append(queryItem)
        }
        if let nationality = paramter.nationality, !nationality.isEmpty {
            let queryItem = URLQueryItem(name: "nat", value: nationality.lowercased())
            queryItems.append(queryItem)
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
}

private extension Data {
    func printJson() {
        // DataをJSON形式の文字列に変換してログ出力
        if let jsonString = String(data: self, encoding: .utf8) {
            print("API Response JSON: \n\(jsonString)")
        } else {
            print("API Response Data could not be converted to UTF-8 string.")
        }
    }
}
