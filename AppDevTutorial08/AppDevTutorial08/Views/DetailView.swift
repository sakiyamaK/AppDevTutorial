import SwiftUI
import SwiftData

struct DetailView: View {
    let scrum: DailyScrum
    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section {
                NavigationLink(destination: MeetingView(scrum: scrum)) {
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
            }

            Section {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            } header: {
                Text("Attendees")
            }

            /*
             ********** 解説 **********

             記録をとるSectionを追加
             */
            Section(header: Text("History")) {

                if scrum.history.isEmpty {
                    /*
                     ********** 解説 **********

                     空なら空っぽ用のコンポーネントを呼び出す
                     */
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                } else {
                    /*
                     ********** 解説 **********

                     書籍はelseで囲ってないがこうした方が分かりやすいと思う
                     */
                    ForEach(scrum.history) { history in
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true                
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                /*
                 ********** 解説 **********

                 saveEdits: { _ in
                 }
                 の
                 { _ in
                 }
                 この部分がsaveEditsの関数の中身

                 つまり
                 普通の関数と違って
                 structやclassのインスタンス生成時に中身を決めることができる
                 */

                DetailEditView(scrum: scrum)
                .navigationTitle(scrum.title)
            }
        }

    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    NavigationStack {
        DetailView(scrum: scrums[0])
    }
}
