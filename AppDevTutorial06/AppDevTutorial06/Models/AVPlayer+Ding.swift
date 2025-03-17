/*
See LICENSE folder for this sample’s licensing information.
*/

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        /*
         ********** 解説 **********

         guard else文はif文の逆

         if (何かしらの評価) {
            // trueならここを実行
         } else {
            // falseならここを実行
         }

         guard (何かしらの評価) else {
            // falseならここを実行
            // さらにreturnなどでこれより下は実行しない
            return
         }

         guard else文は動きとしてはif文の逆だが、意味合いが限定的
         関数の最初に実行して入力パラメータが正しいかどうか判定する（バリデーシェンチェック）ために使う
         */
        /*
         ********** 解説 **********
         guard let hoge = hige else {
            return
         }
         だと
         higeがnilじゃないならhogeに代入する
         nilだったらelse

         */
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else {
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url: url)
    }()
}
