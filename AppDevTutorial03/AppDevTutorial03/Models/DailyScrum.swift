/*
 See LICENSE folder for this sample’s licensing information.
 */

import Foundation

struct DailyScrum: Identifiable {
    /*
     ********** 解説 **********
     UUID
     ユニバーサル・ユニーク・ID(アイデンティファイア)
     世界で絶対にかぶることのない番号を生成する仕組み
     123e4567-e89b-12d3-a456-426614174000みたいな番号を生成する
     世界中のパソコンで毎秒生成したとしてもどれかが偶然かぶるより地球が滅亡する方が先かもしれない
     それぐらい被らない仕組み

     SwiftUIではデータの一意性(かぶらなさ)を重要視して設計された機能がたくさんある


     Identifiableに準拠させると必ずidパラメータを持つことが保証される
     そのidはUUID型じゃなくてもいいけど今回は詳しく説明しない
     */
    let id: UUID
    var title: String
    var attendees: [String]
    var lengthInMinutes: Int
    var theme: Theme

    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design",
                   attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
                   lengthInMinutes: 10,
                   theme: .yellow),
        DailyScrum(title: "App Dev",
                   attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
                   lengthInMinutes: 5,
                   theme: .orange),
        DailyScrum(title: "Web Dev",
                   attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
                   lengthInMinutes: 5,
                   theme: .poppy)
    ]
}
