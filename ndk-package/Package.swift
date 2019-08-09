// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "NDK",
    products: [
       .library(name: "NDKLog", targets: ["NDKLog"])
    ],
    targets: [
       .systemLibrary(name: "sysNDKLog"),
       .target(name: "NDKLog", dependencies: ["sysNDKLog"])
    ]
)
