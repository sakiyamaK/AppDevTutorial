//
//  MeetingTimerView.swift
//  AppDevTutorial10
//
//  Created by sakiyamaK on 2025/04/15.
//

/*
 **** 解説 ****
 新規追加ファイル
 
 */

import SwiftUI

struct MeetingTimerView: View {
    let speakers: [ScrumTimer.Speaker]
    let theme: Theme

    private var currentSpeaker: String {
        speakers.first(where: { !$0.isCompleted })?.name ?? "Someone"
    }

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
    }
}


#Preview {
    let speakers = [ScrumTimer.Speaker(name: "Bill", isCompleted: true), ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    MeetingTimerView(speakers: speakers, theme: .yellow)
}
