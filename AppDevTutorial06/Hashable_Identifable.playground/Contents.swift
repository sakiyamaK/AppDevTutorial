import UIKit

/*
 Hasable
 ハッシュ関数と呼ばれる概念を実現するProtocol

 ハッシュ関数は
 - 入力するパラメータが違えば「必ず」違う出力が得られる
 - 入力が同じなら「必ず」同じ出力が得られる(ランダム性はない)
 - 出力からどんな値が入力されたか知ることは出来ない
 という特徴がある
(原理は大学でやるから端折る)

 Swift言語のHasableではstructやclassのパラメータをハッシュ関数の入力としてhashValueという出力を得るように設計されている
 */

struct UserHashable: Hashable {
    let name: String

    // nameパラメータからハッシュ値を求めるよということ
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

let user1 = UserHashable(name: "田中")
let user2 = UserHashable(name: "鈴木")
let user3 = UserHashable(name: "田中")

//print("名前が違うならhashValueも違う")
//print("user1.name => \(user1.name),  user2.name => \(user2.name)")
//print("user1.hashValue == user2.hashValue => \(user1.hashValue == user2.hashValue)")
//print()
//print("名前が同じならhashValueも同じ")
//print("user1.name => \(user1.name),  user3.name => \(user3.name)")
//print("user1.hashValue == user3.hashValue => \(user1.hashValue == user3.hashValue)")
//print()
//print("hashValueからどんな値が入力されたか知ることはできない")
//print("user1.hashValue => \(user1.hashValue)  => どんな入力からこのhashValueが得られたか分からない")
//print("user2.hashValue => \(user2.hashValue)  => どんな入力からこのhashValueが得られたか分からない")
//print("user3.hashValue => \(user3.hashValue)  => どんな入力からこのhashValueが得られたか分からない")

/*
 具体的な使い所
 ログインのパスワードをハッシュ化してサーバーに送ってDBに保存するとか
 DBに保存されたhashValueがもれてもユーザのパスワード(入力)は分からない
 ユーザが同じパスワードを入力したら同じhashValueが送られてくるからログインの正当性をサーバーで確認できる
 */


print()
print()
print()
print()

/*
 Identifable
 いわゆるIDをもつことが保証されるprotocol

 IDは
 - 他と絶対にかぶらない

 Swift言語のIdentifableは絶対にかぶらないidパラメータを持つようにする
 */

/*
 UUID
 (ほぼ)絶対に被らない値を出力してくれる (原理は大学でやるから端折る)
 偶然かぶる確率は奇跡レベル
 20億台のコンピュータが毎秒1個のUUIDを生成させ続けて28万年後までに被る確率が50%らしい
 そしてこのUUIDの生成アルゴリズムは日々進化しているのでさらに被らなくなっていく
 */

/*
 なのでSwiftではこのUUIDをIdentifiableとして使うことが多い
 とはいえ絶対にIdentifiable.id == UUID型じゃないとダメというわけではない
 自分のシステム上で被らないルールがあるならそれを利用してもいい
 */

struct UserIdentifable: Identifiable {

    let id: String = UUID().uuidString
    var name: String
}

let user4 = UserIdentifable(name: "田中")
let user5 = UserIdentifable(name: "鈴木")
let user6 = UserIdentifable(name: "田中")

print("名前が同じだろうと違っていようとidは必ず違うようにする")
print("user4(id, name) => (\(user4.id),\(user4.name))")
print("user5(id, name) => (\(user5.id),\(user5.name))")
print("user6(id, name) => (\(user6.id),\(user6.name))")
