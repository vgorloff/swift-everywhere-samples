# Requirements

- Xcode 11
- Android Studio 3.4
- Android NDK 20 (Comes with Android Studio as downloadable package).
- Ruby 2.5 (Comes with macOS)

## Usage

1. Make sure that you have [Swift Android Toolchain](https://github.com/vgorloff/swift-everywhere-toolchain). You can either build it or download [pre-build](https://github.com/vgorloff/swift-everywhere-toolchain/releases) version.

2. Make sure that file `Android/local.properties` has proper paths (usually paths already set by `Android Studio`):

   - sdk.dir - Path to Android SDK (by default similar to: /Users/user/Library/Android/sdk)
   - ndk.dir - Path to Android NDK (by default similar to: /Users/user/Library/Android/sdk/ndk-bundle)

3. Copy file `local.properties.yml.template` to `local.properties.yml`. Update file `local.properties.yml` with proper paths:

   - swiftToolchain.dir - Path to Swift Toolchain (by default similar to: /Users/user/git/swift-everywhere-toolchain/ToolChain/swift-android-toolchain)

4. Open `iOS/HelloJNI.xcodeproj` in Xcode 11 and run it on Device or iOS Simulator.

5. Open folder `Android` in Android Studio and run it on Device or Android Simulator.

## Links

- Android NDK: Using C/C++ Native Libraries to Write Android Apps: http://bit.ly/2HjXYJk
- Modern Android NDK Tutorial – Jordan Réjaud – Medium: http://bit.ly/2HvrmLO
