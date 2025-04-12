//
//  Attendee.swift
//  AppDevTutorial08
//
//  Created by sakiyamaK on 2025/04/05.
//
import Foundation
import SwiftData

/*
 ********** 解説 **********

 関係者を管理するモデルを用意する
 */
@Model
class Attendee {
    var name: String
    var dailyScrum: DailyScrum?

    init(name: String) {
        self.name = name
    }
}
