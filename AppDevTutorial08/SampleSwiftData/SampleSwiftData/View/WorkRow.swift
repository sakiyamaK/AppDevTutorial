//
//  WorkRow.swift
//  SampleSwiftData
//
//  Created by sakiyamaK on 2025/05/21.
//

import SwiftUI
import SwiftData

struct WorkRow: View {

    @Binding var work: Work

    var body: some View {
        HStack {
            Button {
                /*
                 SwiftDataは変更を自動的に保存しようとするので明示的なsaveはいらない
                 */
                work.isCompleted.toggle()
            } label: {
                Image(systemName: work.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(work.isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)

            Text(work.title)
                .font(.headline)
                .strikethrough(work.isCompleted, color: .gray)
                .foregroundColor(work.isCompleted ? .gray : .primary)

            Spacer()
        }
        .padding(.vertical, 4)
    }
}
