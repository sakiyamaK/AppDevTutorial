// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Lib",
    //1. iOSの最低サポートバージョンを指定
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "Lib",
            targets: ["Lib"]),
    ],
    // 2. この dependencies セクションを追加して使用するライブラリを登録する
    dependencies: [
        .package(url: "https://github.com/airbnb/lottie-ios.git", from: "4.4.3")
    ],
    targets: [
        // 3. target の dependencies に Lottie を追加
        .target(
            name: "Lib",
            dependencies: [
                .product(name: "Lottie", package: "lottie-ios")
            ]
        )
    ]
)
