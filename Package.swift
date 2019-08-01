// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LSPSwiftClient",
    platforms: [
      .macOS(.v10_13)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "LSPSwiftClient",
            targets: ["LSPSwiftClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pondok-programmer/LanguageClient.git", .branch("master"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "LSPSwiftClient",
            dependencies: ["LanguageClient"]),
        .testTarget(
            name: "LSPSwiftClientTests",
            dependencies: ["LSPSwiftClient"]),
    ]
)
