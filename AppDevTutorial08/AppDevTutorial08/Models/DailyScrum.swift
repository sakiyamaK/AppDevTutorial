import Foundation
/*
 importを忘れないように！！！
 */
import SwiftData

extension Int {
    var doubleValue: Double {
        get {
            Double(self)
        }
        set {
            self = Int(newValue)
        }
    }
}


/*
 ********** 解説 **********

 SwiftDataで読み込んだ属性
 struct(値型)からclass(参照型)に変える
 Model属性を付けるとidも付与されてIdentifableに準拠する必要もなくなる
 */
@Model
final class DailyScrum {

    var title: String

    /*
     ********** 解説 **********

     Relationship属性でデータ構造の親子関係を指定できる

     deleteRule: .cascade を指定すると親が削除されたら子も削除しろという意味
     つまりここなら、このDailyScrumが削除されたら子であるattendeesも全部ハードディスクから消せということになる


     inverse:
     子のパラメータに紐付ける
     めんどくさいのは子の方にもDailyScrum型のパラメータを用意しないといけない
     AttendeeからするとこことRelationshipで関連付いてることが分かりづらいけどこの仕様はどうなんだろ...
     */
    @Relationship(deleteRule: .cascade, inverse: \Attendee.dailyScrum)
    var attendees: [Attendee]
    var lengthInMinutes: Int

    var theme: Theme
    
    @Relationship(deleteRule: .cascade, inverse: \History.dailyScrum)
    var history: [History] = []

    init(title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.title = title
        
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

/*
 ********** 解説 **********
 がっつり書き換えるために消している
 */

//
//extension DailyScrum {
//    struct Attendee: Identifiable {
//        let id: UUID
//        var name: String
//
//        init(id: UUID = UUID(), name: String) {
//            self.id = id
//            self.name = name
//        }
//    }
//
//    static var emptyScrum: DailyScrum {
//        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
//    }
//}
//
//extension DailyScrum {
//    static let sampleData: [DailyScrum] =
//    [
//        DailyScrum(title: "Design",
//                   attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
//                   lengthInMinutes: 10,
//                   theme: .yellow),
//        DailyScrum(title: "App Dev",
//                   attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
//                   lengthInMinutes: 5,
//                   theme: .orange),
//        DailyScrum(title: "Web Dev",
//                   attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
//                   lengthInMinutes: 5,
//                   theme: .poppy)
//    ]
//}
