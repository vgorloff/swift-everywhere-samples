import ndk.log

public struct AndroidLogger {

   @discardableResult
   public static func info(_ message: String) -> Int32 {
      #if os(Android)
      return "ANDROID: \(message)".withCString {
         __android_log_print_1($0)
      }
      #else
      print("NOT AN ANDROID: " + message)
      return 0
      #endif
   }
}
