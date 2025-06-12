//
//  SwiftUIView.swift
//  ikenie_ios
//
//  Created by 塩見陵介 on 2025/05/20.
//

import SwiftUI

struct StudyTaskAppView: View {
    @State private var showAddTask = false
    
    /// ⑥SwiftDataで保存されているものから取得できるようにする
    @State private var tasks = [
        Task(title: "SwiftUI基礎", description: "VStackとHStackの使い方", isCompleted: true),
        Task(title: "アプリ開発演習", description: "計算機アプリを作成する", isCompleted: false),
        Task(title: "データベース連携", description: "FirebaseとSwiftUIの接続", isCompleted: false)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // ヘッダー部分
                HStack {
                    Label("学習タスク管理", systemImage: "book.fill")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("残り \(tasks.filter { !$0.isCompleted }.count) 個")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                // 進捗バー
                ProgressView(value: Double(tasks.filter { $0.isCompleted }.count), total: Double(tasks.count))
                    .padding(.horizontal)
                
                // タスクリスト
                List {
                    ForEach(Array(tasks.enumerated()), id: \.element.id) { index, task in
                        /// ④ここに、タスクタップ時の処理を追加
                        TaskRow(task: task)
//                        { task in
//                        }
                    }
                }
                
                // 下部ボタングループ
                Group {
                    HStack(spacing: 15) {
                        Button(action: {
                            showAddTask = true
                        }) {
                            Label("タスク追加", systemImage: "plus.circle.fill")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            // タスクをリセット
                            var newTasks: [Task] = []
                            for i in 0..<tasks.count {
                                var task = tasks[i]
                                task.isCompleted = false
                                newTasks.append(task)
                            }
                            tasks = newTasks
                        }) {
                            Label("リセット", systemImage: "arrow.clockwise")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    
                    // ヘルプテキスト
                    Text("タスクを追加して学習計画を立てましょう。完了したタスクはチェックを入れて進捗を確認できます。")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
            .navigationTitle("学習管理アプリ")
            .sheet(isPresented: $showAddTask) {
                AddTaskView(tasks: $tasks)
            }
        }
    }
}

// タスク行のビュー
struct TaskRow: View {
    private var task: Task
    /// ①ここにタップ時のクロージャを追加
    
    /// ②タップ時処理を受け取る
    init(task: Task) {
        self.task = task
    }
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(task.isCompleted ? .green : .gray)
                .onTapGesture {
                    /// ③タップ時の処理をこちらで使う
                }
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                Text(task.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

// タスク追加ビュー
struct AddTaskView: View {
    @Binding var tasks: [Task]
    @State private var title = ""
    @State private var description = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section(header: Text("タスク情報")) {
                TextField("タイトル", text: $title)
                TextField("説明", text: $description)
            }
            
            Section {
                Button("追加") {
                    let newTask = Task(title: title, description: description, isCompleted: false)
                    tasks.append(newTask)
                    dismiss()
                }
                .disabled(title.isEmpty)
            }
        }
        .navigationTitle("新規タスク")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("キャンセル") {
                    dismiss()
                }
            }
        }
        
    }
}

/// SwiftDataで扱える形式に変更
struct Task: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    var isCompleted: Bool
}

#Preview {
   StudyTaskAppView()
}
