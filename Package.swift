// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TransformUtils",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        .library(
            name: "TransformUtils",
            targets: ["TransformUtils"]
        ),
    ],
    targets: [
        .target(
            name: "TransformUtils",
            dependencies: []
        ),
    ]
)
