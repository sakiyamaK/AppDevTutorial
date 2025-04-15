//
//  Attendee.swift
//  AppDevTutorial10
//
//  Created by sakiyamaK on 2025/04/05.
//
import Foundation
import SwiftData

@Model
class Attendee {
    var name: String
    var dailyScrum: DailyScrum?

    init(name: String) {
        self.name = name
    }
}
