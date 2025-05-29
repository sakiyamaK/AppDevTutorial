import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    /*
     ********** 解説 **********

     シートを出すかどうか判断するフラグ
     */
    @State private var isPresentingNewScrumView = false

    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
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
            /*
             ********** 解説 **********

             Bindingで受け取ったscrumsをさらにBindingで渡す
             */
            NewScrumSheet(scrums: $scrums)
        }
    }
}

#Preview {
    /*
     ********** 解説 **********

     Preview内でStateを使うにはPreviewableもいる
     */

    @Previewable @State var scrums = DailyScrum.sampleData
    ScrumsView(scrums: $scrums)
}
