//
//  TaskCategory.swift
//  SampleSwiftData
//
//  Created by sakiyamaK on 2025/05/21.
//

import Foundation
import SwiftData

/*
 SwiftData のモデルとして扱うことを宣言
 */
@Model
final class WorkCategory {
    var name: String
    var createAt: Date

    /*
     Workとのリレーションシップ
     WorkCategory が Work を「複数」持つ
     `Cascade` はカテゴリが削除されたら、紐づくタスクも削除される設定
     */
    @Relationship(deleteRule: .cascade, inverse: \Work.category)
    var works: [Work]

    init(name: String) {
        self.name = name
        self.createAt = Date()
        self.works = []
    }
}
