import SwiftUI
import SwiftData

struct ScrumsView: View {

    @Query(sort: \DailyScrum.title) private var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false

    var body: some View {
        NavigationStack {
            List(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)

            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    /*
                     ********** 解説 **********

                     ボタンをタップしたらシートが出るようにする
                     */
                    isPresentingNewScrumView = true

                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView) {
            NewScrumSheet()
        }
    }
}

#Preview {
    ScrumsView()
}
