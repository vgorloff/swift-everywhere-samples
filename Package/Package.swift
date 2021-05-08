// swift-tools-version:5.4

import PackageDescription

let package = Package(
   name: "HelloJNI",
   platforms: [.iOS(.v11)],
   products: [
      // See: https://theswiftdev.com/2019/01/14/all-about-the-swift-package-manager-and-the-swift-toolchain/
      .library(name: "HelloJNICore", type: .dynamic, targets: ["HelloJNICore"]),
   ],
   dependencies: [
      .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", .exact("1.13.0")), // Keep verssion in sync with `protoc-gen-swift --version`,
      .package(url: "https://github.com/apple/swift-log.git", from: "1.4.0")
   ],
   targets: [
      .target(name: "HelloJNICore", dependencies: ["AndroidLog", "saModels"]),
      .target(name: "saModels", dependencies: ["SwiftProtobuf", "CAndroidJNI", .product(name: "Logging", package: "swift-log")]),
      .target(name: "AndroidLog", dependencies: ["CAndroidLog", .product(name: "Logging", package: "swift-log")]),
      .systemLibrary(name: "CAndroidLog"),
      .target(name: "CAndroidJNI")
   ]
)
