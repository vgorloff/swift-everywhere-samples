import Foundation
import NDKLog
#if os(Android)
import FoundationNetworking
#endif

let tester = URLTester()

@_cdecl("Java_com_home_helloNDK_SwiftLib_sayHello")
public func sayHello() -> Int {
   // fatalError()
   AndroidLogger.info("SA - SwiftCore: Works!")
   probeDispatch()
   probeOperation()
   probeSerialization()
   tester.test()
   return Int(Date().timeIntervalSince1970)
}

func probeDispatch() {
   let sema = DispatchSemaphore(value: 0)

   let queue = DispatchQueue(label: "queueName")
   queue.async {
      AndroidLogger.info("SA - DispatchQueue: Works!")
      sema.signal()
   }

   if sema.wait(timeout: .now() + 10) == .timedOut {
      AndroidLogger.info("SA - DispatchQueue: Timeout.")
   }
}

private let opQueue = OperationQueue()

func probeOperation() {
   let op = BlockOperation {
      AndroidLogger.info("SA - BlockOperation: Works!")
   }
   opQueue.addOperations([op], waitUntilFinished: true)
}


func probeSerialization() {
   let json = ["name": "SA - JSONSerialization/JSONDecoder: Works!"]
   do {
      let data = try JSONSerialization.data(withJSONObject: json, options: [])
      struct Person: Decodable {
         let name: String
      }
      let person = try JSONDecoder().decode(Person.self, from: data)
      AndroidLogger.info(person.name)
   } catch {
      AndroidLogger.info(String(describing: error))
   }
}



class URLTester: NSObject {


   let config = URLSessionConfiguration.default
   lazy var session = URLSession(configuration: config)

   func test() {
      AndroidLogger.info("SA - URLSession: Works!")
      if let url = URL(string: "https://www.google.com") {
         let sema2 = DispatchSemaphore(value: 0)
         let task = session.dataTask(with: url) { data, response, error in
            if let response = response {
               AndroidLogger.info("Response: " + String(describing: response))
            }
            if let error = error {
               let nsError = error as NSError
               AndroidLogger.info("Error: " + String(describing: nsError))
               AndroidLogger.info("Error UserInfo: " + String(describing: nsError.userInfo))
            }
            if let data = data {
               AndroidLogger.info("Data: " + String(describing: data))
            }
            sema2.signal()
         }
         task.resume()
         if sema2.wait(timeout: .now() + 10) == .timedOut {
            AndroidLogger.info("Timeout")
         }
         AndroidLogger.info("URL Task Completed")
      } else {
         AndroidLogger.info("bad url")
      }
   }
}
