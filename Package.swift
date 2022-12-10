// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppLogger",
    platforms: [
        .macOS(.v10_10)
    ],
    products: [
        .executable(
            name: "AppLogger",
            targets: ["AppLogger"])
    ],
    targets: [
        .target(
            name: "AppLogger",
            dependencies: [])
    ]
)