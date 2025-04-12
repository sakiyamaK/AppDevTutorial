# 概要

SwiftData

# 参考

https://developer.apple.com/tutorials/app-dev-training/persisting-data

# 説明資料

https://qiita.com/dokozon0/items/0c46c432b2e873ceeb04

https://zenn.dev/maeken/articles/7eee4d797a0571

https://zenn.dev/maochanz/articles/c8592f8cbe2fcc

# SwiftData

iOS17から使用できるデータ永続化のフレームワーク
データの永続化とはメモリに保存するのではなく、ハードディスクに保存されるという意味
つまりアプリを再起動してもデータが残っている
アプリを削除したら消える

プレビューで使うには特別な記述が必要

## 使い方概要
1. import SwiftDataをする
2. 管理したいデータ構造をclassで用意して@Model属性を付ける
3. 他のモデルとの依存関係をRelationshipで管理する
4. 呼び出す画面側でQueryを使う