import SwiftUI
import SwiftData

struct DetailEditView: View {

    let scrum: DailyScrum

    @State private var newAttendeeName = ""
    @State private var title: String
    @State private var lengthInMinutes: Int
    @State private var attendees: [Attendee]
    @State private var theme: Theme
    /*
      **** 解説 ****

     エラーが発生した時用のパラメータを追加
     エラーが発生しないこともあるのでoptional
     */
    @State private var errorWrapper: ErrorWrapper?
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var hoge: Int?

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

            /*
              **** 解説 ****
             エラー発生時のViewを作ったがエラーが起きないと動作確認できない

             そのためタップしたらエラーが出るボタンで動作確認したりする
             あくまで開発段階のもので動作確認できたら消す
             */

#if DEBUG
            Button("error") {
                errorWrapper = ErrorWrapper(
                    error: NSError(domain: "hoge", code: 1),
                    guidance: "Daily scrum was not recorded. Try again later."
                )
            }
#endif
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    /*
                      **** 解説 ****

                     do {
                     }
                     の中でエラーが起きたら
                     catch して
                     発生したエラーを let error に代入する

                     エラーが起きる可能性のあるメソッド(throwsが定義されているメソッド)
                     を実行するにはtryを書く
                     */

                    do {
                        try saveEdits()
                        dismiss()
                    } catch let error {
                        /*
                          **** 解説 ****
                         発生したエラーをOptionalのerrorWrapperに代入する
                         これでエラーが新たに発生したことがStateに伝わる
                         */

                        errorWrapper = ErrorWrapper(error: error, guidance: "Daily scrum was not recorded. Try again later.")
                    }
                }
            }
        }
        /*
          **** 解説 ****

         エラーが発生したらシートで表示
         */
        .sheet(item: $errorWrapper) {
            dismiss()
        } content: { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
    }

    /*
      **** 解説 ****

     throwsで関数内でエラーが発生したことを外部に知らせる

     try? -> try に書き換えた
     try?だとエラーが起きても無視するということだったのであまり良くない
     */
    private func saveEdits() throws {
        scrum.title = title
        scrum.lengthInMinutes = lengthInMinutes
        scrum.attendees = attendees
        scrum.theme = theme

        if isCreatingScrum {
            context.insert(scrum)
        }

        try context.save()
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    DetailEditView(scrum: scrums[0])
}

