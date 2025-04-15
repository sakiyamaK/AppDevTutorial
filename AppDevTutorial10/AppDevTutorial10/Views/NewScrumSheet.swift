//
//  NewScrumSheet.swift
//  AppDevTutorial10
//
//  Created by sakiyamaK on 2025/03/26.
//

import SwiftUI

struct NewScrumSheet: View {

    var body: some View {
        NavigationStack {
            DetailEditView(scrum: nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}
