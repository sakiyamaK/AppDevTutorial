import SwiftUI
import SwiftData

struct ScrumsView: View {
    /*
     解説
     外からBindingで受け取るのではなくQueryでハードディスク(など)から読み込む
     sortなどを指定することで呼び出し方を指定できる
     デフォルトのパラメータにない呼び出し方がしたい場合は自前でロジックを用意できる
     大量のデータから10件だけ欲しい時とか
     https://zenn.dev/maochanz/articles/c8592f8cbe2fcc
     */
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
