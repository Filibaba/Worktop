// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "Worktop",
  platforms: [
    .iOS(.v14),
  ],
  products: [
    .library(name: "Worktop", targets: ["Worktop"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture/", from: "0.15.0"),
  ],
  targets: [
    .target(name: "Worktop",dependencies: [
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    ])
  ]
)
