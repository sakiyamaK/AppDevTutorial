/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
  
    var body: some View {
        /*
         ********** 解説 **********
         NavigationStackが遷移していく画面を積んで管理しているイメージ
         NavigationLinkのdestinationを取得してその画面に遷移する
         */
        NavigationStack {
            List(scrums) { scrum in
                /*
                 ********** 解説 **********
                 destinationをDetailViewに修正している
                 */
                /*
                 ********** 解説 **********
                 listRowBackgroundはList直下のViewしか反応しない（ここでいうNavigationLink）
                 NavigationLink>CardViewに設定しないように注意

                 CardView.background()などで色を付けて、どこまでがCardViewか確認してみよう
                 */
                NavigationLink(destination: DetailView(scrum: scrum)) {
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

        /*
         ********** 解説 **********
         Listがなくても使える
         */
//        NavigationStack {
//            NavigationLink(destination: DetailView(scrum: scrums[0])) {
//                CardView(scrum: scrums[0])
//            }
//            NavigationLink(destination: DetailView(scrum: scrums[1])) {
//                CardView(scrum: scrums[1])
//            }
//        }
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.sampleData)
}
