import Foundation

class AppTimer {

   var onTick: ((Int) -> Void)?

   private var timer: Timer?

   func start() {
      timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
         self?.onTick?(Int(Date().timeIntervalSince1970))
      }
   }

   func stop() {
      timer?.invalidate()
      timer = nil
   }

   deinit {
      stop()
   }
}
