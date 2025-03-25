//
//  History.swift
//  AppDevTutorial07
//
//  Created by sakiyamaK on 2025/03/26.
//


import Foundation

/*
 ********** 解説 **********

 ファイルごと追加

 更新履歴を保存するためのデータ

 */

struct History: Identifiable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]

    /*
     ********** 解説 **********

     Date()とDate.nowは同じ処理で現在日時のインスタンスとなる
     */

    init(id: UUID = UUID(), date: Date = .now, attendees: [DailyScrum.Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
