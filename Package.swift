// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VastClient3",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VastClient3",
            targets: ["VastClient3"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "VastClient3",
            dependencies: [],
                path: "Sources/VastClient"),
//        .testTarget(
//            name: "VastClientTests",
//            dependencies: ["VastClient"],
//            resources: [
//                .process("Assets/Vast4-resources"),
//                .process("Assets/Vast3-resources"),
//                .process("Assets/vast3.xsd"),
//                .process("Assets/vast4.xsd"),
//            ]),
    ])
