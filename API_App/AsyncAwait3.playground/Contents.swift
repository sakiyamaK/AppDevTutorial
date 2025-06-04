import Foundation
import PlaygroundSupport

// -------------------------------------------------------------------------
// 3. 複数の非同期処理を並行して実行する (async let)
// -------------------------------------------------------------------------

func downloadImage(imageName: String) async -> String {
    print("\(imageName) のダウンロード開始...")
    let delay = UInt64.random(in: 1...3) // 1〜3秒のランダムな遅延
    try? await Task.sleep(nanoseconds: delay * 1_000_000_000)
    print("\(imageName) のダウンロード完了！")
    return "\(imageName) (サイズ: \(delay)MB)" // 遅延をサイズに見立てる
}

Task {

    print("--- 3. 複数の非同期処理の並行実行 (async let) ---")

    // `async let` を使うと、複数の非同期処理を同時に開始できます。
    // `await` で結果が必要になるまで、処理はバックグラウンドで進みます。
    async let downloadedImage1 = downloadImage(imageName: "ProfileIcon")
    async let downloadedImage2 = downloadImage(imageName: "BannerImage")

    print("画像とドキュメントのダウンロードを並行して開始しました。")

    // `await` を使って、それぞれの処理の結果を取得します。
    // このとき、まだ完了していない処理があれば、完了するまで待ちます。
    // `downloadedImage1` と `downloadedImage2`、`downloadedDocument` はほぼ同時に開始され、
    // それぞれの処理時間に応じて完了します。
    let image1 = await downloadedImage1
    print("取得した画像1: \(image1)")

    let image2 = await downloadedImage2
    print("取得した画像2: \(image2)")

    print("すべての並行処理が完了しました。")
    print("--- 3. 完了 ---\n")
}

PlaygroundPage.current.needsIndefiniteExecution = true
