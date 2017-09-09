// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Kreds",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "KredsLib",
            targets: ["KredsLib"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/kylef/Commander.git", .upToNextMinor(from: "0.6.0")),
    ],
    targets: [
        .target(
          name: "Kreds",
          dependencies: ["KredsLib"]
        ),
        .target(
            name: "KredsLib",
            dependencies: ["Commander"]),
        .testTarget(
            name: "KredsLibTests",
            dependencies: ["KredsLib"]),
    ]
)
