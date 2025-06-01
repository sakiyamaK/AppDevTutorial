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

    /*
     URLRequest.CachePolicyでキャッシュの扱いを決める

     case useProtocolCachePolicy
     デフォルト
     HTTPプロトコルで定義されているキャッシュ制御情報（レスポンスヘッダーの Cache-Control, Expires, ETag, Last-Modified など）に従います。
     一般的に、サーバー側で適切にキャッシュ設定がされていれば、最も効率的で推奨されるポリシーです。


     case reloadIgnoringLocalCacheData
     ローカルに保存されているキャッシュデータを完全に無視し、常にサーバーにリクエストを送信します。
     用途：
       - プルリフレッシュのように、ユーザーが明示的に最新情報を要求した場合。
       - キャッシュされている可能性のあるデータが古く、強制的にサーバーから再取得したい場合。
     注意：頻繁に使うとサーバー負荷やデータ通信量が増加します。


     case reloadIgnoringLocalAndRemoteCacheData
     【非推奨】このポリシーは現在は非推奨 (deprecated) です。
     代わりに .reloadIgnoringLocalCacheData を使用するよう推奨されています。


     case returnCacheDataElseLoad
     ローカルキャッシュを確認して
     - キャッシュデータが存在すれば、キャッシュデータを返します。
     - キャッシュが存在しない場合、サーバーにリクエストを送信してデータをロードします。
     用途：
       - オフライン時でも、とにかく何か表示できるデータがあれば素早く表示したい場合。
       - データの鮮度よりも表示速度を優先し、古いデータでも許容できる場合。
     注意：キャッシュの鮮度が保証されないため、表示される情報が最新でない可能性があります。


     case returnCacheDataDontLoad
     ローカルキャッシュのみを確認します。
     - キャッシュデータが存在すれば、キャッシュデータを返します。
     - キャッシュが存在しない場合、ネットワークリクエストを行わず、エラーを返します。
     用途：
       - 完全なオフラインモードで、キャッシュされたデータのみでアプリケーションを動作させたい場合。
       - ネットワーク接続の有無に関わらず、絶対にネットワークアクセスを発生させたくないリソースの取得。
       - 特定のデータがキャッシュされていなければ、表示しないという明確な要件がある場合。
     注意：キャッシュがなければデータ取得に失敗します。キャッシュの鮮度も保証されません。


     case reloadRevalidatingCacheData
     ローカルキャッシュが存在する場合、キャッシュが有効かサーバーに問い合わせて検証します。
     この検証は、HTTPの条件付きリクエスト（If-None-Match や If-Modified-Since ヘッダーを使用）によって行われます。
     - サーバーが「変更なし (304 Not Modified)」と応答すれば、ローカルキャッシュのデータを使用します。
     - サーバーが新しいコンテンツを返せば、その新しいデータを使用し、ローカルキャッシュも更新されます。
     - ローカルキャッシュが存在しない場合は、通常通りネットワークからデータをロードします。
     用途：
       - .useProtocolCachePolicy に似ていますが、より明示的に「キャッシュがあればまず検証する」という動作をさせたい場合。
     注意：キャッシュがあっても必ず一度サーバーに問い合わせ（検証リクエスト）が発生するため、完全オフライン時には利用できません。
     */
    struct RequestParameter {
        let gender: String?
        let nationality: String?
        var resultsCount: Int = 10
        var cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
    }


    func fetchUsers(paramter: RequestParameter) async throws -> [User] {
        let requestURL = try makeRequestURL(paramter: paramter)

        // 新規
        // URLRequestにキャッシュポリシーを設定
        var request = URLRequest(url: requestURL)
        request.cachePolicy = paramter.cachePolicy

        print("Fetching users from: \(requestURL.absoluteString)")

        do {
            // 変更
            // URLRequestを渡すdata(for: request)に変える
            let (data, response) = try await URLSession.shared.data(for: request)

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
        if let jsonString = String(data: self, encoding: .utf8) {
            print("API Response JSON: \n\(jsonString)")
        } else {
            print("API Response Data could not be converted to UTF-8 string.")
        }
    }
}
