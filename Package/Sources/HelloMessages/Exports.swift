import Foundation
import NDKLog

@_cdecl("Java_com_home_helloNDK_SwiftLib_sayHello")
public func sayHello() -> Int {
   // fatalError()
   AndroidLogger.info("~~~~ TEST MESSAGE ~~~~")
   return Int(Date().timeIntervalSince1970)
}
