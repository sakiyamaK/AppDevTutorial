import UIKit

// 変数
var greeting = "Hello, playground"

// 定数
let pi = 3.14

// 明示的な型指定
var age: Int = 20
var price: Double = 19.99
let isActive: Bool = true
var message: String = "こんにちは"

// 型推論
var count = 10         // Int と推論される
let temperature = 25.5 // Double と推論される


// optional
// 値のないnil(他の言語でいうNULL)になる可能性のある型
var optionalName1: String? = "Alice"
// String?の別の書き方
var optionalName2: Optional<String> = "Alice"

var optionalAge: Int? // nil が入っている状態

// 強制アンラップ (非推奨: optionalNameがnilだとクラッシュする)
// String?をStringに変える
 print(optionalName1!)

// オプショナルバインディング (安全なアンラップ)
// optionalName1がnilじゃないならnameに代入してnameはStringになってる
if let name = optionalName1 {
    print("名前は \(name) です。")
} else {
    print("名前がありません。")
}

// オプショナルバインディング (安全なアンラップ)
// if let optionalName1 = optionalName1 みたいな書き方をするのが多いので省略できるようになった
// optionalName1がそのまま定数のStringになる
if let optionalName1 {
    print("名前は \(optionalName1) です。")
} else {
    print("名前がありません。")
}

// Nil合体演算子
// optionalName1がnilなら??の後ろを代入する
// displayName自体はString
// デフォルト値とかに使う
let displayName = optionalName1 ?? "ゲスト"
print("表示名: \(displayName)")
