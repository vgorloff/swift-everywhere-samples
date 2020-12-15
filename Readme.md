# swift-everywhere-samples

## Requirements

- macOS 11.x
- Xcode 12.x
- Android Studio 4.1
- Android NDK 21.3.6528147

## Usage

1. Make sure that you have [Swift Android Toolchain](https://github.com/vgorloff/swift-everywhere-toolchain). You can either build it or download [pre-build](https://github.com/vgorloff/swift-everywhere-toolchain/releases) version.

2. Make sure that you have a symlink to NDK directory at `/usr/local/ndk/21.3.6528147`. It should be the **same** as already defined in `android.ndkVersion` in Gradle build configuration file (See: `Android/app/build.gradle`).

   ```sh
   sudo mkdir -p /usr/local/ndk
   sudo ln -vsi ~/Library/Android/sdk/ndk/21.3.6528147 /usr/local/ndk/21.3.6528147
   ```

3. Copy file `example.swiftToolchain.rc` to `swiftToolchain.rc`. Update file `swiftToolchain.rc` with proper paths:

   - `SaSwiftToolchainDirPath` - Path to Swift Toolchain you downloaded or built on step 1.

4. Install "Protocol buffers" for Java and Swift sources generation `brew install protobuf swift-protobuf`

5. (Optional) Generate models: `Scripts/GenerateModels.sh`

6. Open `iOS/HelloJNI.xcodeproj` in Xcode and run it on Device or iOS Simulator.

7. Open folder `Android` in Android Studio and run it on Device or Android Simulator.
