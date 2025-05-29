//
//  ErrorWrapper.swift
//  AppDevTutorial09
//
//  Created by sakiyamaK on 2025/04/13.
//

import Foundation

/*
  **** 解説 ****

 新規に追加したモデル

 公式はコメントアウトしたinitを書いているが
 Swift言語はstructはinitを自前で書かなくても補完してくれる
 */

//struct ErrorWrapper: Identifiable {
//    let id: UUID
//    let error: Error
//    let guidance: String
//
//    init(id: UUID = UUID(), error: Error, guidance: String) {
//        self.id = id
//        self.error = error
//        self.guidance = guidance
//    }
//}

struct ErrorWrapper: Identifiable {
    let id: UUID = UUID()
    let error: Error
    let guidance: String
}
