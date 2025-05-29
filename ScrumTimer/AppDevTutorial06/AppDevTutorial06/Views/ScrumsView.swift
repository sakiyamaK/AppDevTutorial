import SwiftUI

struct ScrumsView: View {
    /*
     ********** 解説 **********

     情報源から値を紐付けるのでBindingに変更
    */

    @Binding var scrums: [DailyScrum]

    var body: some View {
        NavigationStack {
            /*
             ********** 解説 **********
             ListはBindingも渡せる
            */
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    /*
                     ********** 解説 **********
                     本来はここも値を渡さずBindingを渡す方が良いはず
                    */
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)

            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    ScrumsView(scrums: .constant(DailyScrum.sampleData))
}
