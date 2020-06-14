// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "afterparty",
  platforms: [.macOS(.v10_15)],
  products: [
    .library(name: "afterparty", targets: ["App"]),
  ],
  dependencies: [
    // 💧 A server-side Swift web framework.
    .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    
    // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
    .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
    
    .package(url: "https://github.com/dokun1/afterparty-models-swift.git", from: "0.1.0")
  ],
  targets: [
    .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "afterparty-models-swift"]),
    .target(name: "Run", dependencies: ["App"]),
    .testTarget(name: "AppTests", dependencies: ["App"])
  ]
)

