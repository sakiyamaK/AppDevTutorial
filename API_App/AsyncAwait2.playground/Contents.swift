import Foundation
import PlaygroundSupport

// -------------------------------------------------------------------------
// 2. エラーハンドリングを含むAsync/Await
// -------------------------------------------------------------------------
print("--- 2. エラーハンドリング ---")

// エラーを発生させる可能性のある非同期関数
// `async throws` で、この関数が非同期であり、エラーを投げる可能性があることを示します。
func fetchDataWithPossibleError(shouldFail: Bool) async throws -> String {
    print("エラーが発生する可能性のあるデータ取得開始...")
    try? await Task.sleep(nanoseconds: 1 * 1_000_000_000) // 1秒待機

    // 今回は絶対に成功してしまうため強引にエラーを出すパラメータを用意してる
    if shouldFail {
        print("エラー発生！")
        throw NSError(domain: "ネットワーク接続に失敗しました。", code: 10)
    } else {
        print("データ取得成功（エラーなし）")
        return "エラーなしで取得したデータ"
    }
}

Task {
    // エラーハンドリング (成功するケース)
    do {
        // `try await` で、エラーを投げる可能性のある `async` 関数を呼び出します。
        let successData = try await fetchDataWithPossibleError(shouldFail: false)
        print("成功ケースで取得したデータ: \(successData)")
    } catch {
        print("エラーが発生しました: \(error.localizedDescription)")
    }

    // エラーハンドリング (失敗するケース)
    do {
        let failureData = try await fetchDataWithPossibleError(shouldFail: true)
        print("失敗ケースで取得したデータ: \(failureData)") // ここは実行されないはず
    } catch {
        print("エラーが発生しました（予期通り）: \(error.localizedDescription)")
    }
    print("--- 2. 完了 ---\n")
}

PlaygroundPage.current.needsIndefiniteExecution = true
