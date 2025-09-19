// swift-tools-version:5.7
//
//  Package.swift
//  DoubleNode Swift Framework (DNSFramework) - DNSBlankSystems
//
//  Created by Darren Ehlers.
//  Copyright © 2020 - 2016 DoubleNode.com. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "DNSBlankSystems",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .macCatalyst(.v16),
        .watchOS(.v9),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "DNSBlankSystems",
            type: .static,
            targets: ["DNSBlankSystems"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/DoubleNode/DNSCore.git", .upToNextMajor(from: "1.12.0")),
        .package(url: "https://github.com/DoubleNode/DNSCrashNetwork.git", .upToNextMajor(from: "1.12.0")),
        .package(url: "https://github.com/DoubleNode/DNSError.git", .upToNextMajor(from: "1.12.0")),
        .package(url: "https://github.com/DoubleNode/DNSProtocols.git", .upToNextMajor(from: "1.12.0")),
//        .package(path: "../DNSCore"),
//        .package(path: "../DNSCrashNetwork"),
//        .package(path: "../DNSError"),
//        .package(path: "../DNSProtocols"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "DNSBlankSystems",
            dependencies: ["DNSCore", "DNSCrashNetwork", "DNSError", "DNSProtocols"]),
        .testTarget(
            name: "DNSBlankSystemsTests",
            dependencies: ["DNSBlankSystems"]),
    ],
    swiftLanguageVersions: [.v5]
)
