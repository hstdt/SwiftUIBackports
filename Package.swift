// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIBackports",
    platforms: [
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "SwiftUIBackports",
            targets: ["SwiftUIBackports"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/shaps80/SwiftBackports", from: "26.2.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SwiftUIBackports",
            dependencies: ["SwiftBackports", "SwiftUIBackportsObjc"],
            resources: [.process("Resources/PrivacyInfo.xcprivacy")]
        ),
        .target(name: "SwiftUIBackportsObjc"),
    ],
)
