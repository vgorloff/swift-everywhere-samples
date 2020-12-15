package com.home.helloNDK

class SwiftLib {
   companion object {
      init {
         System.loadLibrary("HelloJNICore")
      }
   }

   external fun initialize()
   external fun testDispatch()
   external fun testOperation()
   external fun testSerialization()
   external fun testNetworking()
   external fun printAddressBook(instance: ByteArray)
   external fun getAddressBook(): ByteArray?
}