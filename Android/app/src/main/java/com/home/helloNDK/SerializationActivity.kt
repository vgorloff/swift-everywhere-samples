package com.home.helloNDK

import android.os.Bundle
import swift.SwiftLib

class SerializationActivity : LinearLayoutActivity() {

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)

      val startButton = makeButton("Start (See Logcat or Run / Debug logs)")

      startButton.setOnClickListener {
         execute()
      }
   }

   private fun execute() {
      SwiftLib().testSerialization()
   }
}