package swift

typealias TickHandler = ((Int) -> Unit)

class SwiftTimer {
   companion object {
      init {
         System.loadLibrary("HelloJNICore")
      }
   }

   external fun init()
   external fun destroy()
   external fun start()
   external fun stop()
   external fun setCallback()

   private var onTick: TickHandler? = null

   fun onTick(callBack: (resultVal: Int) -> Unit) {
      onTick = callBack
      setCallback()
   }

   // Callsed by Swift
   public fun callback(timestamp: Int) {
      onTick?.let { timestamp }
   }
}
