import Logging
import Foundation

private let opQueue = OperationQueue()
private let log = Logger(label: "operation-tests")

@_cdecl("Java_swift_SwiftLib_testOperation")
func testOperation() {
   log.info("Starting execution from caller queue on \(Thread.current.name ?? "-")")
   let op = BlockOperation {
      log.info("Message from custom operation on \(Thread.current.name ?? "-")")
   }
   opQueue.addOperations([op], waitUntilFinished: true)
   log.info("Finished execution from caller queue on \(Thread.current.name ?? "-")")
}
