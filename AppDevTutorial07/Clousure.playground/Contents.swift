import Foundation


/*
 closure(クロージャ)
 */

//((String?) -> Void)?というクロージャ型の変数closureを用意
//初期値はnil
var closure: ((String?) -> Void)? = nil

//closureに何も代入されてないので何もしない
print("------ nilなclosureを実行 closure?(\"aaa\") ------")
closure?("aaa")
print("finish")

//無名関数を代入
closure = { (value: String?) -> Void  in
    guard let _value = value else {
        return
    }
    print("closure : \(_value)")
}

//無名関数の中身が実行される
print("------ 無名関数代入済みclosureを実行 closure?(\"aaa\") ------")
closure?("aaa")
print("finish")

/*
 クロージャーを引数に取るapi関数
 completionは「この関数が終わったら最後に実行するクロージャー」という意味だが
 言語仕様ではなく、なんとなく通例でみんながそういう名前を使うようになった
 callbackと書く人もいる

 @Sendableは「複数の並行スレッド間でいったりきたりしても安全に動くよ」ということをコンパイラに保証する
 */
func api(endPoint: String, completion: ( @Sendable (String?) -> Void)? ){

    print("[1] API通信開始: \(endPoint)")

    Task {
        try! await Task.sleep(for: .seconds(3))

        print("[2] API通信終了: \(endPoint)")

        await MainActor.run {
            completion?("success")
        }
    }

    print("[3] API関数の同期部分終了")
}

print("---- api(endpoint:\"https://like\", completion: nil) ---")
api(endPoint:"https://like", completion: nil)
print("[4] finish")

// @Sendableなクロージャ
var sendableClosure: ( @Sendable (String?) -> Void)? = { (value: String?) -> Void  in
    guard let _value = value else {
        return
    }
    print("[5] \(_value)")
}

//クロージャを引数に代入してapi関数を実行
print("---- api(endpoint:\"https://block\", completion: closure) ---")
api(endPoint:"https://block", completion: sendableClosure)
print("[4] finish")

//わざわざ無名関数を引数に代入するのがめんどうなときは直接書く
print("---- api(endpoint:\"https://comment\", completion: /*直接書いた無名関数*/) ---")
api(endPoint:"https://comment", completion: { (value: String?) -> Void  in
    /*
     guard let _value = value else {
         return
     }
     と同じ意味
     valueがnilじゃなければそのままvalueをOptionalじゃない型へと変換する
     */
    guard let value else {
        return
    }
    print("[5]  \(value)")
})
print("[4] finish")


//completionに無名関数を入れる時には省略記法がある、この書き方がもっとも一般的
print("---- api(endpoint:\"https://comment\"){  } ---")
api(endPoint: "https://comment") { (value: String?) in
    guard let value else {
        return
    }
    print("無名関数を直接書いたよ : \(value)")
}
print("[4] finish")


//api関数は無名関数を引数にとるので普通の関数だって引数として使える
func method(rtn: String?){
    guard let value = rtn else {
        return
    }
    print("method : \(value)")
}

print("---- api(endpoint:\"https://login\", completion: method(rtn:)) ---")
api(endPoint:"https://login", completion: method(rtn:))
print("[4] finish")
