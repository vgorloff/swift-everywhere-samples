package com.home.helloNDK

import android.os.Bundle
import android.util.Log
import swift.SwiftTimer

fun noop() {

}

class TimerActivity: LinearLayoutActivity() {

   private val tag = "TimerActivity"
   lateinit var timer: SwiftTimer

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)
      timer = SwiftTimer()
      timer.init()
      timer.onTick { onTick(it) }

      val startButton = makeButton("Start Timer")
      startButton.setOnClickListener {
         startTimer()
      }

      val stopButton = makeButton("Stop Timer")
      stopButton.setOnClickListener {
         stopTimer()
      }
   }

   private fun onTick(timestamp: Int) {
      Log.d(tag, "$timestamp")
   }

   override fun onDestroy() {
      super.onDestroy()
      timer.destroy()
   }

   private fun startTimer() {
      Log.d(tag, "Starting Timer")
      timer.start()
   }

   private fun stopTimer() {
      Log.d(tag, "Stopping Timer")
      timer.stop()
   }
}