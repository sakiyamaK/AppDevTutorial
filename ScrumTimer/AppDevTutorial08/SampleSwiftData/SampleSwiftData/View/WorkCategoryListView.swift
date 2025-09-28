//
//  CategoryListView.swift
//  SampleSwiftData
//
//  Created by sakiyamaK on 2025/05/21.
//

import SwiftUI
import SwiftData


struct WorkCategoryListView: View {

    /*
     デフォルトで用意されているmodelContext環境変数からハードディスクへ書き込むインスタンスを取得
    */
    @Environment(\.modelContext) private var modelContext

    /*
     ハードディスクからWorkCategoryをnameでソートして読み込む
    */
    @Query(sort: \WorkCategory.name) private var categories: [WorkCategory]

    @State private var showingAddCategoryAlert = false
    @State private var newCategoryName: String = ""

    var body: some View {
        List {
            if categories.isEmpty {
                ContentUnavailableView("カテゴリがありません", systemImage: "folder")
            } else {
                ForEach(categories) { category in
                    NavigationLink(destination: WorkListView(category: category)) {
                        Text(category.name)
                            .font(.headline)
                    }
                }
                .onDelete(perform: deleteCategories)
            }
        }
        .navigationTitle("カテゴリ")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showingAddCategoryAlert = true
                }) {
                    Label("カテゴリを追加", systemImage: "folder.badge.plus")
                }
            }
        }
        .alert("新しいカテゴリ", isPresented: $showingAddCategoryAlert) {
            TextField("カテゴリ名", text: $newCategoryName)
            Button("追加", action: addCategory)
            Button("キャンセル", role: .cancel) { }
        } message: {
            Text("新しいカテゴリの名前を入力してください。")
        }
    }

    private func addCategory() {
        guard !newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let newCategory = WorkCategory(name: newCategoryName.trimmingCharacters(in: .whitespacesAndNewlines))
        /*
         新しいデータをmodelContext(ハードディスク)へ書き込む
        */
        modelContext.insert(newCategory)
        newCategoryName = ""
    }

    private func deleteCategories(at offsets: IndexSet) {
        for index in offsets {
            let category = categories[index]
            /*
             指定のデータをmodelContext(ハードディスク)から削除
             @Relationship(deleteRule: .cascade) の設定により、関連したWorkも自動的に削除
             */
            modelContext.delete(category)
        }
    }

    func hoge() {
        //soto
        Task {
            // kakuri
            try? await modelContext.save()
        }
    }
}

#Preview {
    /*
     inMemory: trueとすることでハードディスク内ではなく一時的なメモリ領域を利用するという意味
     つまりpreviewが更新される度にリセットされる
     */
    NavigationView {
        WorkCategoryListView()
            .modelContainer(
                for: [Work.self, WorkCategory.self],
                inMemory: true
            )
    }
}
