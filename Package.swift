// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NFSComponents",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "NFSComponents",
            targets: ["NFSComponents"]
        )
    ],
    targets: [
        .target(
            name: "NFSComponents",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
