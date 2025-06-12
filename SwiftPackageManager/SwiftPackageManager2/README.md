# Swift Package Manager

## Package.swiftで管理する方法

ライブラリを入れるフォルダを作る（ここではLib）

ターミナルでLibフォルダに移動

```
cd Lib
```

ターミナルで以下のコマンドを実行

```
swift package init
```

Xcodeでprojectを開く

File > Add Files to "Project" でLibフォルダを選択

Package.swiftを編集する

## Xcodeに頼らないメリット

Package.swiftを使いまわせる

Xcodeのバージョンアップとかに依存せず使い方が同じ

コマンドで自動化できる

ライブラリを使うファイルを細かく制御できる（ビルドやXcodePreviewが早くなる）
