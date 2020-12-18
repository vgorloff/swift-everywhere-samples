import Dispatch
import Logging
import Foundation

private let log = Logger(label: "dispatch-tests")

@_cdecl("Java_swift_SwiftLib_testDispatch")
func testDispatch() {
   let semaphore = DispatchSemaphore(value: 0)

   log.info("Starting execution from caller queue on \(Thread.current.name ?? "-")")

   let queue = DispatchQueue(label: "my.queue")
   queue.asyncAfter(deadline: .now() + 3.0) {
      log.info("Message from custom queue on \(Thread.current.name ?? "-")")
      semaphore.signal()
   }

   if semaphore.wait(timeout: .now() + 10) == .timedOut {
      log.info("Timeout ocurred on \(Thread.current.name ?? "-")")
   }
   log.info("Finished execution from caller queue on \(Thread.current.name ?? "-")")
}
