package com.home.helloNDK

import android.os.Bundle
import android.util.Log

class TimerActivity: LinearLayoutActivity() {

   private val tag = "TimerActivity"

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)

      val startButton = makeButton("Start Timer")

      startButton.setOnClickListener {
         startTimer()
      }
   }

   private fun startTimer() {
      Log.d(tag, "Starting Timer")
   }
}