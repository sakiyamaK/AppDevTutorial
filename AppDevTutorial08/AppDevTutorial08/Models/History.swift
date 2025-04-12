//
//  History.swift
//  AppDevTutorial08
//
//  Created by sakiyamaK on 2025/03/26.
//


import Foundation
import SwiftData

/*
 ********** 解説 **********

 過去のスクラムの記録
 */

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
