//
//  Attendee.swift
//  AppDevTutorial08
//
//  Created by sakiyamaK on 2025/04/05.
//
import Foundation
import SwiftData

@Model
class Attendee: Identifiable {
    var id: UUID
    var name: String
    var dailyScrum: DailyScrum?

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
