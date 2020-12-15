import Foundation
import AndroidLog
import Logging

private let log = Logger(label: "exports")

@_cdecl("Java_com_home_helloNDK_SwiftLib_initialize")
public func initialize() {
   LoggingSystem.bootstrap(AndroidLogHandler.init)
   log.info("Swift is initialized.")
}
