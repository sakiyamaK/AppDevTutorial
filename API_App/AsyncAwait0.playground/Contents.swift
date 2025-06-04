import Foundation

// Swift5.5以前
// クロージャを使うことで非同期処理を書いていた
@MainActor
func fetchDataFromServer(completion: @escaping ((String) -> Void)) {
    print("サーバーからデータを取得開始...")
    // 2秒待機
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("データの取得完了！")
        completion("サーバーからのレスポンスデータ")
    }
}

//
// 実行はこんな感じ
//
print("Taskを開始します。")
fetchDataFromServer { responseStr in
    print("取得したデータ: \(responseStr)")
    print("--- 1. 完了 ---\n")
}


// APIがひとつだけならまだ許せるが複数のAPIを実行していくと...
@MainActor
func fetchDataFromServer2(completion: @escaping ((String) -> Void)) {
    print("サーバーからデータを取得開始...")
    // 2秒待機
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        print("データの取得完了！")
        completion("サーバーからのレスポンスデータ")
    }
}

// どんどん処理が入れ子の{}になって見づらい...
fetchDataFromServer { responseStr in
    print("取得したデータ1: \(responseStr)")
    print("--- 1. 完了 ---\n")
    fetchDataFromServer2 { responseStr2 in
        print("取得したデータ2: \(responseStr)")
        print("--- 2. 完了 ---\n")

    }
}
