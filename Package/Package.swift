// swift-tools-version:5.0

import PackageDescription

let package = Package(
   name: "HelloJNI",
   products: [
      // See: https://theswiftdev.com/2019/01/14/all-about-the-swift-package-manager-and-the-swift-toolchain/
      .library(name: "HelloJNICore", type: .dynamic, targets: ["HelloJNICore"]),
      .library(name: "NDKLog", targets: ["NDKLog"])
   ],
   targets: [
      .target(name: "HelloJNICore", dependencies: ["NDKLog"]),
      .target(name: "NDKLog", dependencies: ["sysNDKLog"]),
      .systemLibrary(name: "sysNDKLog")
   ]
)
