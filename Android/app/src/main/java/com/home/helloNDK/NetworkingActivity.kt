package com.home.helloNDK

import android.os.Bundle
import android.util.Log
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch
import swift.SwiftLib

class NetworkingActivity : LinearLayoutActivity() {

   private val tag = "NetworkingActivity"

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)

      val startButton = makeButton("Start (See Logcat or Run / Debug logs)")

      startButton.setOnClickListener {
         execute()
      }
   }

   private fun execute() {
      progressDialog.show()
      Log.d(tag, ">>> Starting Button click callback on " + Thread.currentThread().name)
      GlobalScope.launch {
         Log.d(tag, ">>> Starting Swift call on " + Thread.currentThread().name)
         SwiftLib().testNetworking()
         Log.d(tag, "<<< Finishing Swift call on " + Thread.currentThread().name)
         MainScope().launch {
            Log.d(tag, "<<< Finishing Button click callback on " + Thread.currentThread().name)
            progressDialog.dismiss()
         }
      }
   }
}