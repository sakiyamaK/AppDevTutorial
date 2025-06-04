import Foundation
import PlaygroundSupport

// -------------------------------------------------------------------------
// 4. Taskグループ (より複雑な並行処理) ※少し高度なため、参考程度に
// -------------------------------------------------------------------------
print("--- 4. Taskグループ (参考) ---")
// Taskグループは、動的な数のタスクを並行実行し、それらの結果を収集する場合に便利です。

func processItem(id: Int) async -> String {
    print("アイテム \(id) の処理開始...")
    try? await Task.sleep(nanoseconds: UInt64.random(in: 500...1500) * 1_000_000) // 0.5 ~ 1.5秒
    print("アイテム \(id) の処理完了。")
    return "アイテム \(id) の結果"
}

Task {

    let itemIDs = [1, 2, 3, 4, 5]
    var results: [String] = []

    // `withTaskGroup` を使ってタスクグループを作成します。
    // `String.self` は、各タスクが返す結果の型を示します。
    await withTaskGroup(of: String.self) { group in
        for id in itemIDs {
            // `group.addTask` でグループに新しい子タスクを追加します。
            // 各タスクは `processItem` を非同期に実行します。
            group.addTask {
                await processItem(id: id)
            }
        }

        // `for await result in group` で、グループ内のタスクが完了するたびに
        // その結果を非同期に受け取ります。
        // タスクの完了順序は保証されません。
        print("Taskグループ: 各アイテムの処理結果を収集中...")
        for await result in group {
            results.append(result)
            print("Taskグループ: \"\(result)\" を受信")
        }
    }

    print("Taskグループ: すべてのアイテム処理完了。結果: \(results)")
    print("--- 4. 完了 ---\n")
}

PlaygroundPage.current.needsIndefiniteExecution = true
