import Foundation

/*:
 # Codableとは何か？

 `Codable` は、Swiftのデータ構造（`struct` や `class` など）を、
 JSONやProperty Listのような外部のデータ形式と相互に変換するための、
 とても便利なプロトコルです。

 `Codable` は、実際には `Encodable` と `Decodable` という
 ２つのプロトコルを組み合わせたものです。

 - `Decodable`: JSONデータ → Swiftのデータ構造へ「デコード（復元）」
 - `Encodable`: Swiftのデータ構造 → JSONデータへ「エンコード（符号化）」

 これを使うと、複雑な変換コードを書く手間が省けます。
 */

/*:
 ## 1. JSONデータの準備

 今回は、架空のユーザー情報を表すJSONデータを使ってみましょう。
 */

let jsonString = """
{
    "id": "user_001",
    "name": "山田 太郎",
    "age": 30,
    "isPremiumUser": true,
    "interests": ["プログラミング", "読書", "旅行"],
    "address": {
        "prefecture": "東京都",
        "city": "渋谷区"
    }
}
"""

/*:
 ## 2. Swiftのデータモデル (`struct`) の定義

 JSONの構造に合わせて、Swiftの `struct` を定義します。
 この `struct` に `Codable` プロトコルを準拠させるだけでOKです！
 */

// 住所を表す構造体
struct Address: Codable {
    let prefecture: String
    let city: String
}

// ユーザー情報を表す構造体
struct User: Codable { // ここに `Codable` を準拠させるだけ！
    let id: String
    let name: String
    let age: Int
    let isPremiumUser: Bool
    let interests: [String]
    let address: Address // ネストされた構造体もCodableに準拠させる
}

// JSON文字列をData型に変換
guard let jsonData = jsonString.data(using: .utf8) else {
    fatalError("JSON文字列をDataに変換できませんでした。")
}


/*:
 ## 3. Decodable (JSON → Swift) の実演

 `JSONDecoder` を使って、JSONデータからSwiftの `User` オブジェクトを作成してみましょう。
 */

print("--- JSONデータからSwiftオブジェクトへデコード ---")

let decoder = JSONDecoder()

do {
    let user = try decoder.decode(User.self, from: jsonData)

    print("デコード成功！")
    print("ID: \(user.id)")
    print("名前: \(user.name)")
    print("年齢: \(user.age)")
    print("プレミアムユーザー: \(user.isPremiumUser ? "はい" : "いいえ")")
    print("趣味: \(user.interests.joined(separator: ", "))")
    print("住所: \(user.address.prefecture)\(user.address.city)")

} catch {
    print("デコード中にエラーが発生しました: \(error)")
}
print("\n")

/*:
 ## 4. Encodable (Swift → JSON) の実演

 今度は、Swiftの `User` オブジェクトをJSONデータに変換してみましょう。
 */

print("--- SwiftオブジェクトからJSONデータへエンコード ---")

// 新しいUserオブジェクトを作成
let newUser = User(
    id: "user_002",
    name: "鈴木 花子",
    age: 25,
    isPremiumUser: false,
    interests: ["料理", "映画鑑賞"],
    address: Address(prefecture: "大阪府", city: "大阪市")
)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted // JSONを整形して出力するためのオプション

do {
    let encodedData = try encoder.encode(newUser)

    // Data型からJSON文字列に変換して表示
    if let encodedJsonString = String(data: encodedData, encoding: .utf8) {
        print("エンコード成功！")
        print(encodedJsonString)
    } else {
        print("エンコードされたデータを文字列に変換できませんでした。")
    }

} catch {
    print("エンコード中にエラーが発生しました: \(error)")
}
print("\n")

/*:
 ## 5. Codableのまとめ

 `Codable` プロトコルに準拠させるだけで、
 SwiftのデータとJSONデータの間の複雑な変換処理を、
 Swiftが自動的に行ってくれます。

 これにより、API通信で取得したJSONデータをSwiftのオブジェクトとして簡単に扱ったり、
 Swiftのオブジェクトをサーバーに送信するためのJSONデータに簡単に変換したりすることが
 できるようになります。
 */
