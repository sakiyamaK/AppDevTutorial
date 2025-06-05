import Foundation

/*:
 # Codable

 もっと自由に対応付けをする

 APIから値があったりなかったりした時
 ネストされている中の一部だけ欲しい時
 UNIXタイムスタンプからDate型に変えたい時

 などをシンプルなモデルとして扱いたい時など

 */


let json = """
{
    "user_id": "api_user_123",
    "credentials": {
        "user_name": "coder_taro",
        "password_hash": "abc123xyz"
    },
    "last_login_at": 1678886400
}
"""

print("--- 特殊なJSONデータ ---")
print(json)
print("\n")


struct User: Decodable, Identifiable {
    let id: String
    let userName: String // credentials -> userName を平坦化
    let lastLoginDate: Date // Int (UNIXタイムスタンプ) から Date へ変換
    let statusCode: Int // JSONに存在しない場合、デフォルト値0

    private enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case credentials // ネストされたキー
        case lastLoginAt = "last_login_at" // Date変換が必要なキー
        case statusCode = "status_code" // オプショナルになりうるキー
    }

    private enum CredentialsKeys: String, CodingKey {
        case userName = "user_name"
    }

    // MARK: - init(from decoder:) の手動実装
    init(from decoder: Decoder) throws {
        // 1. トップレベルのコンテナを取得
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // 2. userId は直接デコード
        id = try container.decode(String.self, forKey: .id)

        // 3. ネストされた `credentials` コンテナから `username` をデコード
        let credentialsContainer = try container.nestedContainer(keyedBy: CredentialsKeys.self, forKey: .credentials)
        userName = try credentialsContainer.decode(String.self, forKey: .userName)

        // 5. `lastLoginAt` (UNIXタイムスタンプ) を `Date` に変換してデコード
        let timeStamp = try container.decode(TimeInterval.self, forKey: .lastLoginAt)
        lastLoginDate = Date(timeIntervalSince1970: timeStamp)

        // 6. `statusCode` は存在しない場合があるので、`decodeIfPresent` を使用し、
        //    nil の場合はデフォルト値 `0` を設定する
        statusCode = (try container.decodeIfPresent(Int.self, forKey: .statusCode)) ?? 0
    }
}

/*:
 ## 3. デコードの実演

 このように複雑なデコードロジックでも、`init(from decoder:)` を手動で書けば対応できます。
 */

print("--- JSONデータからSwiftオブジェクトへデコード (init(from decoder:)使用) ---")

guard let jsonData = json.data(using: .utf8) else {
    fatalError("JSON文字列をDataに変換できませんでした。")
}

let decoder = JSONDecoder()
// 日付のデコード戦略は不要（手動でTimeIntervalからDateに変換するため）

do {
    let user = try decoder.decode(User.self, from: jsonData)

    print("デコード成功！")
    print("ユーザーID: \(user.id)")
    print("ユーザー名: \(user.userName)")
    print("最終ログイン日時: \(user.lastLoginDate)")
    print("ステータスコード: \(user.statusCode)") // JSONにない場合0になることを確認

} catch {
    print("デコード中にエラーが発生しました: \(error)")
}
print("\n")
