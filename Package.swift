// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Swish",
    products: [
        .library(
            name: "Swish",
            targets: ["Swish"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kylef/PathKit", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Swish",
            dependencies: [ "PathKit" ]),
        .testTarget(
            name: "SwishTests",
            dependencies: ["Swish"]),
    ]
)
