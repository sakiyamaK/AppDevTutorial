# 概要

ソースオブトゥルースの考え方

State、BindingなどのProperty Wrapper

# 説明資料

https://docs.google.com/presentation/d/1wsORbRdv5633m2dglElnDvDDo7PW4T-AcAorh3b5HwQ/edit?usp=sharing

# 参考

https://developer.apple.com/tutorials/app-dev-training/managing-data-flow-between-views

https://developer.apple.com/tutorials/app-dev-training/creating-the-edit-view

# StateとBinding
```swift

---- Bindingじゃない場合 ---

struct CopyView: View {
    @State var copyValue: Int

    var body: some View {
        Text("Copy: \(copyValue)")
    }
}

struct SourceView: View {
    @State var sourceValue: Int = 1

    var body: some View {
        VStack {
            Text("Body: \(sourceValue)")
            CopyView(copyValue: sourceValue)
            Button("値を変更") {
                sourceValue = 2
            }
        }
    }
}

としたらCopyViewインスタンスが作成される時に
copyValueとsourceValueのふたつがメモリにできて
それぞれ1が代入される

sourceValue = 2

と更新しても
コピーされたcopyValueは別のメモリなので何も起きない（元の値の1）

----　Bindingの場合 ----

struct CopyView: View {
    @Binding var copyValue: Int

    var body: some View {
        Text("Copy: \(copyValue)")
    }
}

struct SourceView: View {
    @State var sourceValue: Int = 1

    var body: some View {
        VStack {
            Text("Body: \(sourceValue)")
            CopyView(copyValue: $sourceValue)
            Button("値を変更") {
                sourceValue = 2
            }
        }
    }
}

としたらCopyViewインスタンスが作成される時に
copyValueはメモリに値を持たずsourceValueと同じメモリを参照しますよ
となる

そのため
sourceValue = 2

と更新したら
copyValueも同じメモリを参照してるので2になる

これでsourceValueが
唯一の絶対の情報源（シングルソースオブトゥルース）となる
```

