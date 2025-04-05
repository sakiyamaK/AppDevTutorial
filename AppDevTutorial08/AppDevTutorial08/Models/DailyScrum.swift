import Foundation
/*
 ********** 解説 **********

 iOS17から使用できるデータ永続化のフレームワークのSwiftDataを使う
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
 パラメータのidは変数にしないといけない
 */
@Model
final class DailyScrum: Identifiable {
    var id: UUID
    var title: String

    @Relationship(deleteRule: .cascade, inverse: \Attendee.dailyScrum)
    var attendees: [Attendee]
    var lengthInMinutes: Int

    var theme: Theme
    
    @Relationship(deleteRule: .cascade, inverse: \History.dailyScrum)
    var history: [History] = []

    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
}

/*
 ********** 解説 **********

 @Modelを利用した書き方に変えるため削除する
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
