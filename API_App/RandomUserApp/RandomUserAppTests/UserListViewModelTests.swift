//
//  RandomUserAppTests.swift
//  RandomUserAppTests
//
//  Created by sakiyamaK on 2025/10/08.
//

// 2024のWWDCで発表された最新のテストフレームワーク
import Testing
// テスト対象のアプリをimportする
@testable import RandomUserApp

/*
 テストコードの書き方

 1 最初はわざと失敗させてテストコードが正しく実行していることを確認する
 2 それからテストのロジックを書く

******** 注意 ********
 実際はUserListViewModelはテストがしづらい設計になっているためあまり良くない
 テストしやすいコードを書くことが現場では求められている

 だけどテストしやすいコードを書くためには色々なテクニックが必要で学習が困難になるため、
 ここでは現状のUserListViewModelのままテストコードを書く
 */

struct UserListViewModelTests {

//    @Test("テストコードの練習")
//    func example() async throws {
//        #expect(1 == 0)
//    }

    @Test("男性だけ検索")
    func searchOnlyMale() async throws {

        let viewModel = UserListViewModel()

        viewModel.selectedGender = .male

        await viewModel.searchUsers()

        let users = viewModel.users

        #expect(
            users.allSatisfy(
                {
                    user in user.gender ==  UserListViewModel.GenderType.male.apiValue
                })
        )
    }

    @Test("女性だけ検索")
    func searchOnlyFeMale() async throws {

        let viewModel = UserListViewModel()

        viewModel.selectedGender = .female

        await viewModel.searchUsers()

        let users = viewModel.users

        #expect(
            users.allSatisfy(
                {
                    user in user.gender ==  UserListViewModel.GenderType.female.apiValue
                })
        )
    }

    @Test("アメリカだけで検索")
    func searchOnlyUS() async throws {
        let viewModel = UserListViewModel()
        viewModel.selectedNationality = .us
        await viewModel.searchUsers()
        let users = viewModel.users

        #expect(
            users.allSatisfy(
                {
                    user in user.nat ==  UserListViewModel.NationalityType.us.apiValue
                })
        )
    }

    @Test("フランスかつ男性だけで検索")
    func searchOnlyFranceAndMale() async throws {

        let viewModel = UserListViewModel()

        viewModel.selectedNationality = .fr
        viewModel.selectedGender = .male

        await viewModel.searchUsers()

        let users = viewModel.users

        #expect(
            users.allSatisfy({user in
                user.nat == UserListViewModel.NationalityType.fr.apiValue &&
                user.gender == UserListViewModel.GenderType.male.apiValue
            })
        )
    }

    @Test("初期値で検索")
    func searchDefault() async throws {

        let viewModel = UserListViewModel()

        await viewModel.searchUsers()

        // ローディングが終わって、errorMessageがnilなことを確認
        // サーバーの都合でusers.countが0の時がある
        #expect(
            viewModel.isLoading == false &&
            viewModel.errorMessage == nil
        )
    }

    /*
     argumentsの配列で一度に複数のパターンをテストできる
     */
    @Test(
        "全ての性別のパラメータで検索",
        arguments: UserListViewModel.GenderType.allCases
    )
    func search(gender: UserListViewModel.GenderType) async throws {

        let viewModel = UserListViewModel()

        viewModel.selectedGender = gender

        await viewModel.searchUsers()

        let users = viewModel.users

        switch gender {
        case .all:
            // ローディングが終わって、errorMessageがnilなことを確認
            #expect(
                viewModel.isLoading == false &&
                viewModel.errorMessage == nil
            )
        default:
            #expect(
                users.allSatisfy({ user in
                    user.gender == gender.apiValue
                })
            )
        }
    }

    /*
     タプルで複数の型をひとつにまとめて、さらにその配列をargumentsとする

     タプルごとにテストが動く
     */
    @Test(
        "いくつかのパラメータで検索",
        arguments: [
            (
                UserListViewModel.NationalityType.all,
                UserListViewModel.GenderType.all
            ),
            (
                UserListViewModel.NationalityType.us,
                UserListViewModel.GenderType.all
            ),
            (
                UserListViewModel.NationalityType.gb,
                UserListViewModel.GenderType.female
            ),
            (
                UserListViewModel.NationalityType.all,
                UserListViewModel.GenderType.male
            ),
        ]
    )
    func search(nationality: UserListViewModel.NationalityType, gender: UserListViewModel.GenderType) async throws {

        let viewModel = UserListViewModel()

        viewModel.selectedNationality = nationality
        viewModel.selectedGender = gender

        await viewModel.searchUsers()

        let users = viewModel.users

        switch (nationality, gender) {
            // どっちにかにallが含まれていたら数が0じゃないことだけ確認
        case (.all, _), (_, .all):
            #expect(
                viewModel.isLoading == false &&
                viewModel.errorMessage == nil
            )
        default:
            #expect(
                users.allSatisfy({ user in
                    user.nat == nationality.apiValue &&
                    user.gender == gender.apiValue
                })
            )
        }
    }
}
