import Foundation
import PlaygroundSupport // Playgroundで非同期処理を正しく待つために必要です。

// `async` キーワードは、この関数が非同期であることを示します。
// この関数は、完了するまでに時間がかかる可能性のある処理を含みます。

func fetchDataFromServer() async -> String {
    print("サーバーからデータを取得開始...")
    // 2秒待機
    try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    print("データの取得完了！")
    return "サーバーからのレスポンスデータ"
}

// `async`関数を呼び出すために、`Task`ブロックを使用します。
// Playgroundのトップレベルでは、`async`関数を直接`await`で呼び出せないので、
// `Task` で囲むか、別の `async` 関数の中から呼び出す必要があります。
Task {
    print("Taskを開始します。")
    // `await` キーワードは、`async`関数が完了するまで待機することを示します。
    // `fetchDataFromServer()` の処理が終わるまで、次の行には進みません。
    let data = await fetchDataFromServer()
    print("取得したデータ: \(data)")
    print("--- 1. 完了 ---\n")
}

func fetchDataFromServer2() async -> String {
    print("サーバーからデータを取得開始...")
    // 2秒待機
    try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
    print("データの取得完了！")
    return "サーバーからのレスポンスデータ"
}

// APIが連続しても入れ子にならず流れが追いやすい
Task {
    print("Taskを開始します。")
    let data = await fetchDataFromServer()
    print("取得したデータ: \(data)")
    print("--- 1. 完了 ---\n")
    let data2 = await fetchDataFromServer2()
    print("取得したデータ: \(data2)")
    print("--- 2. 完了 ---\n")
}

// Playgroundで非同期処理の完了を待つために設定する
PlaygroundPage.current.needsIndefiniteExecution = true
