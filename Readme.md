# Requirements

- Xcode 12.x
- Android Studio 4.1
- Android NDK 20.1.5948944. **Note**: NDK 21.0.6113669 or above cannot be used with libDispatch at the moment due compile errors addressed clang/libc++ update.
- Ruby 2.6.3 (ruby -v)
- CMake 3.17.3 (cmake --version)
- Ninja 1.10.0 (ninja --version)

## Usage

1. Make sure that you have [Swift Android Toolchain](https://github.com/vgorloff/swift-everywhere-toolchain). You can either build it or download [pre-build](https://github.com/vgorloff/swift-everywhere-toolchain/releases) version.

2. Make sure that you have a symlink to NDK directory at `/usr/local/ndk/20.1.5948944`. It should be the **same** as defined in `android.ndkVersion` in Gradle build configuration file.

   ```sh
   sudo mkdir -p /usr/local/ndk
   sudo ln -vsi ~/Library/Android/sdk/ndk/20.1.5948944 /usr/local/ndk/20.1.5948944
   ```

4. Copy file `local.properties.yml.template` to `local.properties.yml`. Update file `local.properties.yml` with proper paths:

   - `swiftToolchain.dir` - Path to Swift Toolchain (by default similar to: /Users/user/git/swift-everywhere-toolchain/ToolChain/swift-android-toolchain)

5. Open `iOS/HelloJNI.xcodeproj` in Xcode and run it on Device or iOS Simulator.

6. Open folder `Android` in Android Studio and run it on Device or Android Simulator.
