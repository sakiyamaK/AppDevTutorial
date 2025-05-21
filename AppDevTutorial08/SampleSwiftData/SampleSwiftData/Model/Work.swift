//
//  Work.swift
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
final class Work {
    var title: String
    var isCompleted: Bool
    var createAt: Date

    var category: WorkCategory?

    init(title: String, category: WorkCategory? = nil) {
        self.title = title
        self.isCompleted = false
        self.createAt = Date()
        self.category = category
    }
}
