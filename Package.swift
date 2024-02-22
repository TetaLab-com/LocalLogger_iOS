// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalLogger_iOS",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LocalLogger_iOS",
            targets: ["LocalLogger_iOS"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LocalLogger_iOS",
            resources: [
                .process("Resources/Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "LocalLogger_iOSTests",
            dependencies: ["LocalLogger_iOS"]),
    ]
)
