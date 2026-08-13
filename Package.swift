// swift-tools-version:6.2

/**
*  Ink
*  Copyright (c) Alan DeGuzman 2026
*  Copyright (c) John Sundell 2019
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "Ink",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "Ink", targets: ["Ink"]),
        .executable(name: "ink-cli", targets: ["InkCLI"])
    ],
    targets: [
        .target(name: "Ink"),
        .executableTarget(name: "InkCLI", dependencies: ["Ink"]),
        .testTarget(name: "InkTests", dependencies: ["Ink"])
    ]
)
