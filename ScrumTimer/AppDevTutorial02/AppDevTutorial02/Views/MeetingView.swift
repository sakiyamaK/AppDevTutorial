//
//  ContentView.swift
//  AppDevTutorial01
//
//  Created by sakiyamaK on 2025/03/15.
//

import SwiftUI

struct MeetingView: View {
    var body: some View {
        VStack {
            ProgressView(value: 5, total: 15)

            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("300", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Seconds Remaining")
                        .font(.caption)
                    Label("600", systemImage: "hourglass.bottomhalf.fill")
                }
            }

            Spacer()

            Circle()
                .stroke(lineWidth: 24)
                .padding()

            Spacer()

            HStack {
                Text("Speaker 1 of 3")
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "forward.fill")
                }
            }
        }
        .padding()
    }
}

#Preview {
    MeetingView()
}
