/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    var body: some View {
        List {
            /*
             ********** 解説 **********
             Section(header: ) {}
             は書き方が変わった
             
             Section(content: {}, header: {}, footer: {})
             
             Swiftの省略形の呼び出し方をすると
             
             Section {
             
             } header: {
             
             } footer: {
             
             }
             */
            Section {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            } header: {
                Text("Meeting Info")
            } footer: {
                HStack {
                    Spacer()
                    Button(action: {
                        print("増えろ")
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            
            Section {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            } header: {
                Text("Attendees")
            }
        }
        .navigationTitle(scrum.title)
    }
}


#Preview {
    NavigationStack {
        DetailView(scrum: DailyScrum.sampleData[0])
    }
}
