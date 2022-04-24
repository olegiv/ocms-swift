// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "ocms-swift",
    platforms: [
       .macOS(.v12)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
//        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        .package(url: "https://github.com/binarybirds/swift-html", from: "1.2.0"),
        .package(url: "https://github.com/brokenhandsio/leaf-error-middleware.git", from: "3.0.0")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
               // .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "SwiftHtml", package: "swift-html"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "LeafErrorMiddleware", package: "leaf-error-middleware")
            ],
            swiftSettings: [
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),
        .executableTarget(name: "Run", dependencies: [.target(name: "Core")]),
        .testTarget(name: "CoreTests", dependencies: [
            .target(name: "Core"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
