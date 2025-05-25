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
            .overlay  {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
                }
            }
            .padding(.horizontal)
    }
}


#Preview {
    let speakers = [
        ScrumTimer.Speaker(
            name: "Bill",
            isCompleted: true
        ),
        ScrumTimer.Speaker(
            name: "Cathy",
            isCompleted: true
        )
    ]
    MeetingTimerView(speakers: speakers, theme: .yellow)
}
