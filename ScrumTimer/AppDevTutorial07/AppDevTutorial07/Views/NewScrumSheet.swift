//
//  NewScrumSheet.swift
//  AppDevTutorial07
//
//  Created by sakiyamaK on 2025/03/26.
//

import SwiftUI

/*
 ********** 解説 **********

 ファイルごと追加

 あたらしいscrumを作るための画面

 */
struct NewScrumSheet: View {


    /*
     ********** 解説 **********

     新しいscrumを作るために初期値として空のscrumであるemptyScrumを代入している

     */
    @State private var newScrum = DailyScrum.emptyScrum

    /*
     ********** 解説 **********

     既存のscrumを全て外からBindingで受け取る
     */
    @Binding var scrums: [DailyScrum]

    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum, saveEdits: { dailyScrum in
                /*
                 ********** 解説 **********

                 サンプルではappendメソッドを呼んでるけど += の方が分かりやすいから好き
                 みんなはどっちでもいいよ
                 */
                scrums += [dailyScrum]
            })
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData))
}
