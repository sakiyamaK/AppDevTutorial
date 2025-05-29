/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
  
    var body: some View {
        /*
         ********** 解説 **********

         Listはたくさんのデータを一列に並べる(表形式で並べる)

         この時に表示させるデータは一意性を保ってないといけない
         Listに対して「このデータは一意ですよ、あなたの中でidとして使ってください」
         と明示的に指示することもできる
         ただし明示しておいて一意じゃないとバグるから注意
        */


        /*
         ********** 解説 **********
         \.titleはSwiftのKeyPathという機能の使い方

         ここで具体的なデータを呼び出したり代入しているわけではなく
         「DailyScrumのtitleパラメータを参照してください」
         という意味
        */
        List(scrums, id: \.title) { scrum in
            CardView(scrum: scrum)
                .listRowBackground(scrum.theme.mainColor)
        }

        /*
         表示させるデータがIdentifableに準拠しているなら明示しなくても勝手にデータのidをListのidとして利用する
         今回の場合ならDailyScrum.id
         */
        List(scrums) { scrum in
            CardView(scrum: scrum)
                .listRowBackground(scrum.theme.mainColor)
        }
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.sampleData)
}
