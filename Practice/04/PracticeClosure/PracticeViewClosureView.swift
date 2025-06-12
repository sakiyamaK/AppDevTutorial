//
//  PracticeViewClosureView.swift
//  ikenie_ios
//
//  Created by 塩見陵介 on 2025/06/04.
//

import SwiftUI

struct PracticeViewClosureView: View {
    let users = ["田中", "佐藤", "鈴木"]
    
    var body: some View {
        
        /// 以下でユーザーごとのViewを渡す（デザインは自由）
//        CustomListView(items: users) { user in
//        }
    }
}

/// - <T, Content: View>
/// -  ジェネリクスという書き方。
///  - Tは何の型が入っても良いという意味。
///  - ContentはViewが入るという意味。
struct CustomListView<T, Content: View>: View {
    let items: [T]
    // content Viewを返すクロージャーを追加したい
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(items.indices, id: \.self) { index in
                    // ここで各アイテムをクロージャーでViewに変換したい
                }
            }
        }
    }
}

#Preview {
    PracticeViewClosureView()
}
