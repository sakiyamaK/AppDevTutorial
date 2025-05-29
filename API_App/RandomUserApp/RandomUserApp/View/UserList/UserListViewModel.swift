//
//  UserListViewModel.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import Foundation

@Observable
final class UserListViewModel {
    var users: [User] = []
    var isLoading: Bool = false
    var errorMessage: String?

    // 検索条件
    var selectedGender: String = "" // "male", "female", "" (全て)
    var selectedNationality: String = "" // "us", "gb", など

    // 性別と国籍の選択肢
    let genders = ["全て", "男性", "女性"]
    let nationalities = ["全て", "US", "GB", "FR", "DE"]

    private var api: API = .shared

    func searchUsers() async {
        isLoading = true
        errorMessage = nil

        let genderParam: String? = (selectedGender == genders.first) ? nil : selectedGender
        let natParam: String? = (selectedNationality == nationalities.first) ? nil : selectedNationality

        do {
            self.users = try await api.fetchUsers(
                paramter: API.RequestParameter(
                    gender: genderParam,
                    nationality: natParam,
                    resultsCount: 10
                )
            )
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            print("Error fetching users: \(error)")
        }
    }
}
