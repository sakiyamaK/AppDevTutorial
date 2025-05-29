//
//  WorkListView.swift
//  SampleSwiftData
//
//  Created by sakiyamaK on 2025/05/21.
//

import SwiftUI
import SwiftData

struct WorkListView: View {
    /*
     デフォルトで用意されているmodelContext環境変数からハードディスクへ書き込むインスタンスを取得
    */
    @Environment(\.modelContext) private var modelContext

    @Environment(\.dismiss) private var dismiss

    /*
     Queryで読み込んだデータはStateじゃないのでBinding型に変えられない
     そのため @Bindingじゃなく @Bindableを使う
     */
    @Bindable var category: WorkCategory

    /*
     配列は @Bindableにできないしcategory.works自体は自動で更新されない
     そのためここでStateとしてデータをもつ
     シングルソースオブトゥルースじゃないから他にやりようがありそうなんだが...
     */
    @State private var works: [Work] = []

    @State private var showingAddWorkAlert = false
    @State private var newWorkTitle: String = ""

    var body: some View {
        List {
            if works.isEmpty {
                ContentUnavailableView("タスクがありません", systemImage: "checklist")
            } else {
                ForEach($works) { work in
                    WorkRow(work: work)
                }
                .onDelete(perform: deleteWorks)
            }
        }
        .navigationTitle(category.name)
        .onAppear {
            /*
             @Query が直接 category.works に適用できないため、onAppear で手動で割り当てる
             SwiftDataは自動で変更を監視してくれるので、一度代入してやるといい
             */
            works = category.works.sorted { $0.createAt < $1.createAt }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showingAddWorkAlert = true
                }) {
                    Label("タスクを追加", systemImage: "plus.circle.fill")
                }
            }
        }
        .alert("新しいタスク", isPresented: $showingAddWorkAlert) {
            TextField("タスク名", text: $newWorkTitle)
            Button("追加", action: addWork)
            Button("キャンセル", role: .cancel) { }
        } message: {
            Text("新しいタスクの名前と優先度を入力してください。")
        }
    }

    private func addWork() {
        guard !newWorkTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        /*
         新しいタスクを作成してハードディスクに保存する
         */
        let newWork = Work(
            title: newWorkTitle.trimmingCharacters(in: .whitespacesAndNewlines),
            category: category
        )
        modelContext.insert(newWork)

        /*
         @Stateのworksにも追加してUIを更新（ @Queryではないため手動で更新 ）
         */
        works.append(newWork)
        works.sort { $0.createAt < $1.createAt }

        newWorkTitle = ""
    }

    private func deleteWorks(at offsets: IndexSet) {
        for index in offsets {
            /*
             指定したWorkをハードディスクから削除する
             */
            let deleteWork = category.works[index]
            modelContext.delete(deleteWork)
            /*
             @Stateのworksからも削除してUIを更新（ @Queryではないため手動で更新 ）
             */
            works.remove(at: index)
        }
    }
}
#Preview {
    /*
     inMemory: trueとすることでハードディスク内ではなく一時的なメモリ領域を利用するという意味
     つまりpreviewが更新される度にリセットされる
     */
    NavigationView {
        WorkListView(category: .init(name: "テスト"))
            .modelContainer(
                for: [Work.self, WorkCategory.self],
                inMemory: true
            )
    }
}
