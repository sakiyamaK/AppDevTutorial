# 概要

HashableとIdentifiable

エラーハンドリング

# 参考

https://developer.apple.com/tutorials/app-dev-training/handling-errors

# エラーハンドリング

アプリケーションというものは常に想定通り動くわけではない

今時ならもっとも多いのが、電波が悪い環境とか、サーバーが混み合ってるとか
で発生する通信エラー

次に多いのがハードディスクやメモリの容量不足による保存できないエラー

エラーが起きた場合にはユーザに知らせる必要がある

だいたいのプログラミング言語にはエラー専用の型が用意されている

## 参考
SampleError/SampleError.xcodeproj

# HashableとIdentifableとUUID

## 説明スライド

https://docs.google.com/presentation/d/1Mxftp3e2GDBK9Lu14yJp1ApXdEpyWkgv-XTo97yJx5s/edit?usp=sharing

## 参考
Hashable_Identifable.playground

# 追加/変更箇所

## 移動
DailyScrum.swift内に書いてたIntのextensionをExtensions/Int+swift

## 追加
Models/ErrorWrapper.swift
Views/ErrorView.swift

## 変更
Views/MeetingView.swift
Views/DetailEditView.swift
Views/DetailView.swift

