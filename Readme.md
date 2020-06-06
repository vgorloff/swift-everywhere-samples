# Requirements

- Xcode 11.5
- Android Studio 4.0
- Android NDK 20.1.5948944. **Note**: NDK 21.0.6113669 or above cannot be used with libDispatch at the moment due compile errors addressed clang/libc++ update.
- Ruby 2.6.3 (ruby -v)
- CMake 3.17.3 (cmake --version)
- Ninja 1.10.0 (ninja --version)

## Usage

1. Make sure that you have [Swift Android Toolchain](https://github.com/vgorloff/swift-everywhere-toolchain). You can either build it or download [pre-build](https://github.com/vgorloff/swift-everywhere-toolchain/releases) version.

2. Make sure that file `Android/local.properties` has proper paths (usually paths already set by `Android Studio`):

   - `sdk.dir` - Path to Android SDK (by default similar to: /Users/user/Library/Android/sdk)
   - `ndk.dir` - Path to Android NDK (by default similar to: /Users/user/Library/Android/sdk/ndk/20.1.5948944)

3. Make sure that you have a symlink to NDK directory at `/usr/local/ndk`. It should be the **same** as defined in `ndk.dir` in `Android/local.properties` file.

   ```sh
   sudo ln -fvs /path/to/ndk/20.1.5948944 /usr/local/ndk
   ```

4. Copy file `local.properties.yml.template` to `local.properties.yml`. Update file `local.properties.yml` with proper paths:

   - `swiftToolchain.dir` - Path to Swift Toolchain (by default similar to: /Users/user/git/swift-everywhere-toolchain/ToolChain/swift-android-toolchain)

5. Open `iOS/HelloJNI.xcodeproj` in Xcode and run it on Device or iOS Simulator.

6. Open folder `Android` in Android Studio and run it on Device or Android Simulator.
