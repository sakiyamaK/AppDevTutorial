import SwiftUI

struct DetailEditView: View {
    /*
     ********** 解説 **********
     @Hoge はSwiftのPropertyWrapperという機能
     @Hoge var hige: Int　と定義されている時に
     $higeとするとIntとは別の関連した型が取得される

     @StateはSwiftUIが実装している機能
     @State var hige: Int と定義されている時に
     $higeとするとBinding<Int>型が取得される

     BindingもPropertyWrapperのひとつ
     自身のメモリ空間に値を持たず、他にある値と連動してますよ
     みたいなイメージ(実際はどうなってるのか知らない)

     より詳細な解説はREADME.mdに記載
     */
    @State private var scrum = DailyScrum.emptyScrum
    @State private var newAttendeeName = ""

    var body: some View {
        /*
         ********** 解説 **********

         FormはListと同じく要素を縦に並べる
         Listと違ってユーザの入力を受け付けるように特化している
         */
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
    }
}


#Preview {
    DetailEditView()
}
