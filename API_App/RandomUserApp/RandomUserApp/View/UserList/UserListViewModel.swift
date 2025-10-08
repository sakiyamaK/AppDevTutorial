//
//  UserListViewModel.swift
//  RandomUserApp
//
//  Created by sakiyamaK on 2025/05/29.
//

import Foundation

@Observable
final class UserListViewModel {
    // 性別の選択肢
    enum GenderType: CaseIterable, Identifiable {

        case all, male, female //, hoge

        var id: String { displayName }

        var displayName: String {
            switch self {
            case .all: "全て"
            case .male: "男性"
            case .female: "女性"
//            case .hoge: "ほげ"
            }
        }

        var apiValue: String? {
            switch self {
            case .all: nil
            case .male: "male"
            case .female: "female"
//            case .hoge: "hoge"
            }
        }
    }
    // 国籍の選択肢
    enum NationalityType: CaseIterable, Identifiable {

        case all, us, gb, fr, de

        var id: String { displayName }

        var displayName: String {
            switch self {
            case .all: "全て"
            case .us: "US"
            case .gb: "GB"
            case .fr: "FR"
            case .de: "DE"
            }
        }

        var apiValue: String? {
            switch self {
            case .all: nil
            case .us: "US"
            case .gb: "GB"
            case .fr: "FR"
            case .de: "DE"
            }
        }
    }

    var users: [User] = []
    var isLoading: Bool = false
    var errorMessage: String?

    // 検索条件
    var selectedGender: GenderType = .all
    var selectedNationality: NationalityType = .all

    private var api: API = .shared

    func searchUsers() async {
        isLoading = true
        errorMessage = nil

        do {
            let responseUsers = try await api.fetchUsers(
                paramter: API.RequestParameter(
                    gender: selectedGender.apiValue,
                    nationality: selectedNationality.apiValue,
                    resultsCount: 10
                )
            )
            self.users = responseUsers.filter { $0.id.isNotEmpty }
            self.isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            print("Error fetching users: \(error)")
        }
    }
}
