/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        /*
         ********** 解説 **********

         Pickerは複数の選択肢からひとつを選ぶためのコンポーネント
         pickerStyleで色々な選択の仕方がある

         ForEachで選択肢を登録する
         選択肢のレイアウトはForEachのループの中で指定する
         選択肢のコンポーネントを区別するためにtagにHashableに準拠したデータを渡す
         */

        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    ThemePicker(selection: .constant(.periwinkle))
}
