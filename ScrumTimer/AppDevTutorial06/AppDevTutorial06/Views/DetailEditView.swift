import SwiftUI

struct DetailEditView: View {
    /*
     ********** 解説 **********

     外から値を紐付けるのでBindingに変更
     */
    @Binding var scrum: DailyScrum
    @State private var newAttendeeName = ""

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
    }
}


#Preview {
    DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
}
