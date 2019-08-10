// swift-tools-version:5.0

import PackageDescription

let package = Package(
   name: "HelloMessages",
   products: [
      // See: https://theswiftdev.com/2019/01/14/all-about-the-swift-package-manager-and-the-swift-toolchain/
      .library(name: "HelloMessages", type: .dynamic, targets: ["HelloMessages"]),
      .library(name: "NDKLog", targets: ["NDKLog"])
   ],
   targets: [
      .target(name: "HelloMessages", dependencies: ["NDKLog"]),
      .systemLibrary(name: "sysNDKLog"),
      .target(name: "NDKLog", dependencies: ["sysNDKLog"])
   ]
)
