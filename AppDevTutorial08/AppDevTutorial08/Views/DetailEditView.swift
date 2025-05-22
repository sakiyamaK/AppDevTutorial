import SwiftUI
import SwiftData

struct DetailEditView: View {

    let scrum: DailyScrum

    /*
     ********** 解説 **********

     スクラムの編集をするため、新規の情報を個別のパラメータで管理する
     @State private var newScrum: DailyScrum
     みたいにした方がいいと思うが、サンプル通りにしてみる
     */
    @State private var newAttendeeName = ""
    @State private var title: String
    @State private var lengthInMinutes: Int
    @State private var attendees: [Attendee]
    @State private var theme: Theme

    @Environment(\.dismiss) private var dismiss
    /*
     ********** 解説 **********

     AppDevTutorial08App.swiftで指定している
     modelContainer(for: DailyScrum.self)
     にアクセスできるようになる
     これによって得られるパラメータはデフォルト設定ではハードディスク領域への読み書きとなる
     */
    @Environment(\.modelContext) private var context

    private let isCreatingScrum: Bool

    init(scrum: DailyScrum?) {
        let scrumToEdit: DailyScrum
        if let scrum {
            scrumToEdit = scrum
            isCreatingScrum = false
        } else {
            scrumToEdit = DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
            isCreatingScrum = true
        }

        self.scrum = scrumToEdit
        self.title = scrumToEdit.title
        self.lengthInMinutes = scrumToEdit.lengthInMinutes
        self.attendees = scrumToEdit.attendees
        self.theme = scrumToEdit.theme
    }

    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                HStack {
                    Slider(value: $lengthInMinutes.doubleValue, in: 5...30, step: 1) {
                        Text("Length")
                    }

                    Spacer()

                    Text("\(lengthInMinutes.doubleValue) minutes")
                }
                ThemePicker(selection: $theme)
            } header: {
                Text("Meeting Info")
            }

            Section {
                ForEach(attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = Attendee(name: newAttendeeName)
                            attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            } header: {
                Text("Attendees")
            }
        }
        .toolbar {
            /*
             ********** 解説 **********

             ツールバーが複雑になってきたからこっちに持ってきた

             だけどNavigationStackから呼び出さないとtoolbarは表示されない
             そのためここのPreviewでは表示されないので注意
             */

            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    saveEdits()
                    dismiss()
                }
            }
        }
    }

    private func saveEdits() {
        scrum.title = title
        scrum.lengthInMinutes = lengthInMinutes
        scrum.attendees = attendees
        scrum.theme = theme

        /*
         ********** 解説 **********

         データベースとなっているcontextに新たなデータを挿入して保存している

         var scrumms: [DailyScrum]
         みたいな記述は基本はメモリー領域から読み書きされるわけだが、contextはハードディスクから読み書きして永続化することになる
         メモリー領域のように瞬時に読み書きできないしディスクの故障で書き込めないこともありえるので特別なハードディスクに保存するためのsaveという記述になる
         何度も言うが永続化というメリットのために使う
         */


        if isCreatingScrum {
            context.insert(scrum)
        }

        try? context.save()
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    DetailEditView(scrum: scrums[0])
}
