package com.home.helloNDK

import android.app.ProgressDialog
import android.graphics.Color
import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import android.widget.Button
import android.widget.LinearLayout

open class LinearLayoutActivity: AppCompatActivity() {

   lateinit var layout: LinearLayout
   lateinit var progressDialog: ProgressDialog

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)

      layout = LinearLayout(this)
      layout.orientation = LinearLayout.VERTICAL
      layout.layoutParams = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT)
      layout.setBackgroundColor(Color.LTGRAY)
      setContentView(layout)

      progressDialog = ProgressDialog(this)
      progressDialog.setMessage("Please wait...")
      progressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER)
      progressDialog.setCancelable(false)
   }

   fun makeButton(text: String): Button {
      val myButton = Button(this)
      myButton.text = text
      myButton.setBackgroundColor(Color.WHITE)
      val buttonParams = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.WRAP_CONTENT)
      layout.addView(myButton, buttonParams)
      return myButton
   }

}