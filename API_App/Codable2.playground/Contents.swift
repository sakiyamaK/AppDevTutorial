import UIKit

/*:
 # Codable: キー名のマッピング (CodingKeys)

 JSONのキー名がそのままデコードできない時

 `enum CodingKeys` を使ってJSONのどのキーがどのプロパティか対応付ける
 */

/*:
 ## 1. マッピングが必要なJSONデータの準備
 */

let json = """
{
    "user_id": "u_98765",
    "full_name": "佐藤 恵子",
    "age": 28,
    "switch": false
}
"""

print("--- マッピングが必要なJSONデータ ---")
print(json)
print("\n")


/*:
 ## 2. Swiftのデータモデルの定義と `CodingKeys`

 JSONのキー名と異なるプロパティ名を持つ場合に、`CodingKeys` を定義します。

 **ルール:**
 1.  `enum CodingKeys: String, CodingKey` として定義する。
 2.  `CodingKeys` の中に、**JSONのキー名とSwiftのプロパティ名が異なるもの、および、デコード/エンコードしたい全てのプロパティ**を `case` で列挙する。
 3.  JSONのキー名とSwiftのプロパティ名が異なる場合は、`case swiftPropertyName = "json_key_name"` の形式で記述する。
 4.  JSONのキー名とSwiftのプロパティ名が**同じ場合でも、`CodingKeys` を定義したなら、全てのプロパティを列挙する必要がある。** （これが少し手間ですが、正確な動作のためです）
 */

// ユーザー情報を表す構造体
struct User: Codable {
    let id: String
    let fullName: String
    let age: Int
    let isActiveUser: Bool

    // CodingKeysを定義した時点で、デコード/エンコードしたい全てのプロパティを列挙する必要がある
    private enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case fullName = "full_name"
        case age // 対応付けがいらないものは文字列を指定しなくていい
        case isActiveUser = "switch"
    }
}

/*:
 ## 3. Decodable (JSON → Swift) の実演

 `JSONDecoder` を使って、`DetailedUser` オブジェクトを作成してみましょう。
 `CodingKeys` を定義しておけば、`decoder.decode()` の呼び出し方は変わりません。
 */

print("--- JSONデータからSwiftオブジェクトへデコード (CodingKeys使用) ---")

guard let jsonData = json.data(using: .utf8) else {
    fatalError("JSON文字列をDataに変換できませんでした。")
}

let decoder = JSONDecoder()

do {
    let user = try decoder.decode(User.self, from: jsonData)

    print("デコード成功！")
    print("ユーザーID: \(user.id)")
    print("フルネーム: \(user.fullName)")
    print("年齢: \(user.age)")
    print("アクティブユーザー: \(user.isActiveUser ? "はい" : "いいえ")")
} catch {
    print("デコード中にエラーが発生しました: \(error)")
}
