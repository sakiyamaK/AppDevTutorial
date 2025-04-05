//
//  History.swift
//  AppDevTutorial08
//
//  Created by sakiyamaK on 2025/03/26.
//


import Foundation
import SwiftData

@Model
class History: Identifiable {
    var id: UUID
    var date: Date
    var attendees: [Attendee]
    var dailyScrum: DailyScrum?


    init(id: UUID = UUID(), date: Date = .now, attendees: [Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
