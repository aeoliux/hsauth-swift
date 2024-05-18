// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "hsauth-swift",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
        .visionOS(.v1),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "hsauth-swift",
            targets: ["hsauth-swift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/M3DZIK/swift-libcrypto.git", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "hsauth-swift",
            dependencies: [
                .product(name: "LibCrypto", package: "swift-libcrypto")
            ]
        ),
        .testTarget(
            name: "hsauth-swiftTests",
            dependencies: [
                "hsauth-swift",
                .product(name: "LibCrypto", package: "swift-libcrypto")
            ]),
    ]
)
