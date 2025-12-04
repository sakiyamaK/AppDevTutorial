//
//  API.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import Foundation

final class API {
    static let shared = API()

    private let apiKey = "kKmcTu2Rc6a16T4juPzMKa6wDx0tuJIC7RRfG8bZ" // APIキーが必要ならここ
    private let host = " https://wxtech.weathernews.com/api/v1/ss1wx"

    struct RequestParameter {
        let gender: String?
        let nationality: String?
        var resultsCount: Int = 10        
    }

    func fetchUsers(parameter: RequestParameter) async throws -> [User] {
        let urlRequest = try makeRequestURL(parameter: parameter)

        do {

//            let requestURL = URL(string: "https://www.amazon.co.jp/増補改訂第3版-Swift実践入門")!

            // (Data, URLResponse)のタプルとして戻り値が得られる
            // Dataは生の01の羅列を集めた型
            // サーバーからの戻り値はどんな形式か実装中に分かるものではないためDataとして受け取るようになってる
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }

            // デバッグ用
            // 受け取ったData型をString型に変換してprintする
//            data.printJson()

            let decodedResponse = try JSONDecoder().decode(RandomUserResponse.self, from: data)
            return decodedResponse.results

        } catch let decodingError as DecodingError {
            throw NetworkError.decodingError(decodingError)
        } catch {
            throw NetworkError.unknown(error)
        }
    }

    // hostとパラメータからリクセストするURLを構築する
    private func makeRequestURL(parameter: RequestParameter) throws -> URLRequest {


        // URLComponentsを使うとパラメータをいい感じにエスケープしてくる
        // エスケープとはURLには使えない文字を別の文字に対応すること
        /*
         例 amazonの日本語

         https://www.amazon.co.jp/増補改訂第3版-Swift実践入門-直感的な文法と安全性を兼ね備えた言語-PRESS-plusシリーズ/dp/4297112132/ref=sr_1_1_sspa?__mk_ja_JP=カタカナ&crid=30M1R35Z7D0B8&dib=eyJ2IjoiMSJ9.7VEnHRVLs0Mf5wIuzGzuNunnDG2OawN8Mc3k907606PoygHAuU0QkRVMsdpL52rKTZh6DlW14ssIt5jxo4uQZGq8QBzHptfIV-pqUQ9lABCugyyJ2B7CyHDyB8vTTqEGhnMqwUgllrYr1O5sCa-qPJki12uKNcYw9UMWGMTdXhbNgZ6GtdCzsuUWek7UuB7CNmae60DnW9NtVcGKQ86tmIdhwStJpZBrnLMJQN9bc4uuvop1eoG37qLX3XEhlnLNG431WvUcnla4uIr4i5zTVbMD12_drab0s12JdUeawVE.3IOBv9iVeunn44JPo_l1C8y62swoVt8vRwGyBETLqMk&dib_tag=se&keywords=Swift&qid=1748771703&sprefix=swift,aps,272&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1

         エスケープするとこうなる

         https://www.amazon.co.jp/%E5%A2%97%E8%A3%9C%E6%94%B9%E8%A8%82%E7%AC%AC3%E7%89%88-Swift%E5%AE%9F%E8%B7%B5%E5%85%A5%E9%96%80-%E7%9B%B4%E6%84%9F%E7%9A%84%E3%81%AA%E6%96%87%E6%B3%95%E3%81%A8%E5%AE%89%E5%85%A8%E6%80%A7%E3%82%92%E5%85%BC%E3%81%AD%E5%82%99%E3%81%88%E3%81%9F%E8%A8%80%E8%AA%9E-PRESS-plus%E3%82%B7%E3%83%AA%E3%83%BC%E3%82%BA/dp/4297112132/ref=sr_1_1_sspa?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&crid=30M1R35Z7D0B8&dib=eyJ2IjoiMSJ9.7VEnHRVLs0Mf5wIuzGzuNunnDG2OawN8Mc3k907606PoygHAuU0QkRVMsdpL52rKTZh6DlW14ssIt5jxo4uQZGq8QBzHptfIV-pqUQ9lABCugyyJ2B7CyHDyB8vTTqEGhnMqwUgllrYr1O5sCa-qPJki12uKNcYw9UMWGMTdXhbNgZ6GtdCzsuUWek7UuB7CNmae60DnW9NtVcGKQ86tmIdhwStJpZBrnLMJQN9bc4uuvop1eoG37qLX3XEhlnLNG431WvUcnla4uIr4i5zTVbMD12_drab0s12JdUeawVE.3IOBv9iVeunn44JPo_l1C8y62swoVt8vRwGyBETLqMk&dib_tag=se&keywords=Swift&qid=1748771703&sprefix=swift%2Caps%2C272&sr=8-1-spons&sp_csd=d2lkZ2V0TmFtZT1zcF9hdGY&psc=1

         */

        var components = URLComponents(string: host)!
        // components.queryItemsに代入する配列を構築していく
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "results", value: "\(parameter.resultsCount)")
        ]

        if let gender = parameter.gender, !gender.isEmpty {
            let queryItem = URLQueryItem(name: "gender", value: gender.lowercased())
            queryItems.append(queryItem)
        }
        if let nationality = parameter.nationality, !nationality.isEmpty {
            let queryItem = URLQueryItem(name: "nat", value: nationality.lowercased())
            queryItems.append(queryItem)
        }

        // components.queryItemsに代入
        components.queryItems = queryItems

        // componentsに設定されているパラメータ等からURLを生成する
        // 不正な状態になっていたらnilとなる
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        // ヘッダ情報を登録する必要があるならここ
        var urlRequest = URLRequest(url: url)

        if !apiKey.isEmpty {
            urlRequest.httpMethod = "GET"
            // 例えばAPIキーなど
            urlRequest.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        }
        return urlRequest
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
