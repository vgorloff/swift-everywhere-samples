package com.home.helloNDK

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.system.Os
import swift.SwiftLib
import java.io.File
import java.io.FileOutputStream
import java.io.IOException

class MainActivity : LinearLayoutActivity() {
   override fun onCreate(savedInstanceState: Bundle?) {
      try {
         Os.setenv("CFFIXED_USER_HOME", this.filesDir.path, true)
         // See:
         // - https://forums.swift.org/t/partial-nightlies-for-android-sdk/25909/41?u=v.gorlov
         // - https://github.com/apple/swift-corelibs-foundation/blob/84d6a68f05793f55c1a3aecf553c74fe2fae2ae9/Foundation/URLSession/libcurl/EasyHandle.swift#L187-L200
         val certificatesFile = getCachedAsset(this, "cacert.pem")
         Os.setenv("URLSessionCertificateAuthorityInfoFile", certificatesFile.absolutePath, true)
         // Os.setenv("URLSessionCertificateAuthorityInfoFile", "INSECURE_SSL_NO_VERIFY", true);
      } catch (e: Exception) {
         e.printStackTrace()
      }
      super.onCreate(savedInstanceState)
      SwiftLib().initialize()

      val showDispatchButton = makeButton("Show \"Dispatch\" Screen")
      showDispatchButton.setOnClickListener {
         startActivity(Intent(this, DispatchActivity::class.java))
      }

      val showOpButton = makeButton("Show \"Operation\" Screen")
      showOpButton.setOnClickListener {
         startActivity(Intent(this, OperationActivity::class.java))
      }

      val showSerializationButton = makeButton("Show \"Serialization\" Screen")
      showSerializationButton.setOnClickListener {
         startActivity(Intent(this, SerializationActivity::class.java))
      }

      val showNetButton = makeButton("Show \"Networking\" Screen")
      showNetButton.setOnClickListener {
         startActivity(Intent(this, NetworkingActivity::class.java))
      }

      val showAddressBookButton = makeButton("Show \"AddressBook\" Screen")
      showAddressBookButton.setOnClickListener {
         startActivity(Intent(this, AddressBookActivity::class.java))
      }

      /* Temporary disabled. Still not working properly.
      See:

      - JNI Types and Data Structures: https://docs.oracle.com/javase/7/docs/technotes/guides/jni/spec/types.html
      - java - Call function pointer from JNI - Stack Overflow: https://stackoverflow.com/questions/6619980/call-function-pointer-from-jni
      - ndk-samples/hello-jnicallback.c at master · android/ndk-samples: https://github.com/android/ndk-samples/blob/master/hello-jniCallback/app/src/main/cpp/hello-jnicallback.c
      - JNI - How to callback from C++ or C to Java? - Stack Overflow: https://stackoverflow.com/questions/9630134/jni-how-to-callback-from-c-or-c-to-java
      - Java Native Interface (JNI) - Java Programming Tutorial: https://www3.ntu.edu.sg/home/ehchua/programming/java/JavaNativeInterface.html#zz-6.1
      - swift-jni/SwiftJNI.swift at devel · SwiftAndroid/swift-jni: https://github.com/SwiftAndroid/swift-jni/blob/devel/Sources/JNI/SwiftJNI.swift

      val showTimerButton = makeButton("Show \"Timer\" Screen")
      showTimerButton.setOnClickListener {
         startActivity(Intent(this, TimerActivity::class.java))
      }
      */
   }

   @Throws(IOException::class)
   private fun getCachedAsset(context: Context, name: String): File {
      val cacheFile = File(context.cacheDir, name)
      try {
         val inputStream = context.assets.open(name)
         try {
            val outputStream = FileOutputStream(cacheFile)
            try {
               val buf = ByteArray(1024)
               var len: Int
               while (inputStream.read(buf).also { len = it } > 0) {
                  outputStream.write(buf, 0, len)
               }
            } finally {
               outputStream.close()
            }
         } finally {
            inputStream.close()
         }
      } catch (e: IOException) {
         throw IOException(String.format("Could not open %s", name), e)
      }
      return cacheFile
   }
}