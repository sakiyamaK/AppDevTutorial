//
//  PracticeListClosureView.swift
//  ikenie_ios
//
//  Created by 塩見陵介 on 2025/06/04.
//

import SwiftUI
import SwiftData

@Model
class TodoItem {
    var id: Int
    var title: String
    var isCompleted: Bool
    
    init(id: Int, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}

struct PracticeListClosureView: View {
    /// こちらを、SwiftDataから読み出すように変更する
    @State var itemList: [TodoItem] = []
    
    var body: some View {
        List {
            ForEach(itemList) { item in
                /// 削除、編集のメソッドをこちらからパラメータで入れる
                TodoItemView(item: item)
            }
        }
        .navigationBarTitle("Todo List")
        .toolbar {
            Button("追加") {
                
            }
        }
    }
}

/// 編集、削除の処理を外から取得し、タップすると実行できるようにする
struct TodoItemView: View {
    let item: TodoItem
    
    var body: some View {
        HStack {
            Text(item.title)
                .strikethrough(item.isCompleted)
            
            Spacer()
            
            Button("編集") {
                // 編集アクションを実行したい
            }
            
            Button("削除") {
                // 削除アクションを実行したい
            }
        }
        .padding()
    }
}

#Preview {
    PracticeListClosureView()
}
