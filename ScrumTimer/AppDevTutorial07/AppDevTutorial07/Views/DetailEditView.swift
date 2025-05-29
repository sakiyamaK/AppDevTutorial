import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    /*
     ********** 解説 **********

     (DailyScrum) -> Void

     クロージャと呼ばれる機能
     C言語の頃からあるっちゃある(関数ポインタと呼ばれる)
     プログラミング言語仕様の山場のひとつ
     ひとまず今は中身がないけどこういう関数を定義したと思えばいい
     func saveEdits(_ value: DailyScrum)

     https://note.com/sakiyamak/n/nf40752b88f98
     */
    let saveEdits: (DailyScrum) -> Void
    @State private var newAttendeeName = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Form {
            Section {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutes.doubleValue, in: 5...30, step: 1) {
                        Text("Length")
                    }

                    Spacer()

                    Text("\(scrum.lengthInMinutes) minutes")
                }
                ThemePicker(selection: $scrum.theme)
            } header: {
                Text("Meeting Info")
            }

            Section {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
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
                    saveEdits(scrum)
                    dismiss()
                }
            }
        }
    }
}


#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]

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

    DetailEditView(scrum: $scrum, saveEdits: { _ in
        print("save !!")
    })

}
