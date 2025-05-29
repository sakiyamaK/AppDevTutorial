import Foundation
import SwiftData


@Model
final class DailyScrum {

    var title: String
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
