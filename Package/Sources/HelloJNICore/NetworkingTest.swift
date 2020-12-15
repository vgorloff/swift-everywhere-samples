import Foundation
#if os(Android)
import FoundationNetworking
#endif

import Logging

private let log = Logger(label: "networking-tests")

@_cdecl("Java_com_home_helloNDK_SwiftLib_testNetworking")
public func testNetworking() {
   NetworkingTester().test()
}

class NetworkingTester: NSObject {

   let config = URLSessionConfiguration.default
   lazy var session = URLSession(configuration: config)

   func test() {
      log.info("SA - URLSession: Works!")
      if let url = URL(string: "https://www.google.com") {
         let sema2 = DispatchSemaphore(value: 0)
         let task = session.dataTask(with: url) { data, response, error in
            if let response = response {
               log.info("Response: \(String(describing: response))")
            }
            if let error = error {
               let nsError = error as NSError
               log.info("Error: \(String(describing: nsError))")
               log.info("Error UserInfo: \(String(describing: nsError.userInfo))")
            }
            if let data = data {
               log.info("Data: \(String(describing: data))")
            }
            sema2.signal()
         }
         task.resume()
         if sema2.wait(timeout: .now() + 10) == .timedOut {
            log.info("Timeout")
         }
         log.info("URL Task Completed")
      } else {
         log.info("bad url")
      }
   }
}
