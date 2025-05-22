import SwiftUI
import SwiftData

struct DetailEditView: View {

    let scrum: DailyScrum

    @State private var newAttendeeName = ""
    @State private var title: String
    @State private var lengthInMinutes: Int
    @State private var attendees: [Attendee]
    @State private var theme: Theme
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
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    do {
                        try saveEdits()
                        dismiss()
                    } catch let error {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Daily scrum was not recorded. Try again later.")
                    }
                }
            }
        }
        .sheet(item: $errorWrapper) {
            dismiss()
        } content: { wrapper in
            ErrorView(errorWrapper: wrapper)
        }
    }

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
