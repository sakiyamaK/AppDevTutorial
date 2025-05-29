//
//  History.swift
//  AppDevTutorial10
//
//  Created by sakiyamaK on 2025/03/26.
//


import Foundation
import SwiftData

@Model
class History {
    var date: Date
    var attendees: [Attendee]
    var dailyScrum: DailyScrum?

    init(date: Date = .now, attendees: [Attendee]) {
        self.date = date
        self.attendees = attendees
    }
}
