package com.home.helloNDK

import android.os.Bundle
import android.util.Log
import com.home.addressBook.AddressBookProtos
import swift.SwiftLib

class AddressBookActivity : LinearLayoutActivity() {

   private val tag = "AddressBookActivity"

   override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)

      val toButton = makeButton("Send to Swift (See Logcat or Run / Debug logs)")
      toButton.setOnClickListener {
         printAddressBook()
      }

      val fromButton = makeButton("Get from Swift (See Logcat or Run / Debug logs)")
      fromButton.setOnClickListener {
         getAddressBook()
      }
   }

   private fun getAddressBook() {
      val swiftLib = SwiftLib()
      val serialized = swiftLib.getAddressBook()
      try {
         val ab = AddressBookProtos.AddressBook.parseFrom(serialized)
         Log.i(tag, ab.toString())
      } catch (e: Exception) {
         Log.e(tag, "can't parse", e)
      }
   }

   private fun printAddressBook() {
      val phoneNumber = AddressBookProtos.Person.PhoneNumber.newBuilder().setNumber("12345678").build()
      val person = AddressBookProtos.Person.newBuilder().addPhones(phoneNumber).build()
      val addressBook = AddressBookProtos.AddressBook.newBuilder().addPeople(person).build()
      val data = addressBook.toByteArray()
      val swiftLib = SwiftLib()
      swiftLib.printAddressBook(data)
   }
}
