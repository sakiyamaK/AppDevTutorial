//
//  User.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//


import SwiftUI

struct UserSearchCriteriaView: View {

    @Bindable var viewModel: UserListViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("検索条件")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.horizontal)

            Picker("性別", selection: $viewModel.selectedGender) {
                ForEach(viewModel.genders, id: \.self) { gender in
                    Text(gender).tag(gender)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            HStack {
                Text("国籍")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                Picker("国籍", selection: $viewModel.selectedNationality) {
                    ForEach(viewModel.nationalities, id: \.self) { nat in
                        Text(nat).tag(nat)
                    }
                }
            }
            .padding(.horizontal)

            Button {
                Task {
                    await viewModel.searchUsers()
                }
            } label: {
                Text("ユーザーを検索")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(viewModel.isLoading)
        }
        .padding(.vertical)
        .background(Color.white)
        .cornerRadius(15)
    }
}

#Preview(traits: .fixedLayout(width: 300, height: 200)) {
    UserSearchCriteriaView(viewModel: UserListViewModel())
}
