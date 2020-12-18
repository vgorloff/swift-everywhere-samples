import Foundation
import Logging
import CAndroidJNI

private let log = Logger(label: "serialization-tests")

private var timer: AppTimer?

@_cdecl("Java_swift_SwiftTimer_init")
func initTimer() {
   log.info("Making timer instance...")
   timer = AppTimer()
}

@_cdecl("Java_swift_SwiftTimer_destroy")
func destroyTimer() {
   log.info("Deleting timer instance...")
   timer = nil
}

@_cdecl("Java_swift_SwiftTimer_start")
func timerStart() {
   log.info("Starting timer...")
   timer?.start()
   timer?.onTick?(1) // Just for testing.
}

@_cdecl("Java_swift_SwiftTimer_stop")
func timerStop() {
   log.info("Stopping timer...")
   timer?.stop()
}

@_cdecl("Java_swift_SwiftTimer_setCallback")
func setCallback(env: UnsafeMutablePointer<JNIEnv?>, me: jobject, classref: jobject) {
   log.info("Setting callback...")
   timer?.onTick = { timestamp in
      CallVoidMethod(env, classref, "callback", "(I)V")
   }
}
