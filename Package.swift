// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUtils",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SwiftUtils",
            targets: ["SwiftUtils"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUtils",
            dependencies: [],
            swiftSettings: [
                .unsafeFlags([
                    "-strict-concurrency=minimal",
                ])
            ]
        )
    ]
)
