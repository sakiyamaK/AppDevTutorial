//
//  NewScrumSheet.swift
//  AppDevTutorial08
//
//  Created by sakiyamaK on 2025/03/26.
//

import SwiftUI

struct NewScrumSheet: View {

    /*
     ********** 解説 **********

     全体で管理しているmodelContainerからデータを読み込みするので
     いわゆるバケツリレー的なBindingがいらなくなった
     */

    var body: some View {
        NavigationStack {
            DetailEditView(scrum: nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}
