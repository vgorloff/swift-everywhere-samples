//
//  File.swift
//
//
//  Created by Vlad Gorlov on 27.11.20.
//

import Foundation
import Logging
import CAndroidJNI

private let log = Logger(label: "pb")

public func makeAddressBook() -> SAAddressBook {
   var phone = SAPerson.PhoneNumber()
   phone.number = "Swift12345678"
   var person = SAPerson()
   person.phones.append(phone)
   var book = SAAddressBook()
   book.people.append(person)
   return book
}

@_cdecl("Java_swift_SwiftLib_printAddressBook")
public func printAddressBook(env: UnsafeMutablePointer<JNIEnv?>, me: jclass, bytes: jbyteArray) {
   log.info("printAddressBook")
   let l = GetArrayLength(env, me, bytes)
   log.info("Array length: \(l)")
   let bytes = GetByteArrayElements(env, me, bytes)
   log.info("printAddressBook \(bytes)")
   let data = Data(bytes: bytes, count: Int(l))
   log.info("printAddressBook \(data)")
   let book = try! SAAddressBook(serializedData: data)
   log.info("\(book)")
}

@_cdecl("Java_swift_SwiftLib_getAddressBook")
public func getAddressBook(env: UnsafeMutablePointer<JNIEnv?>, me: jclass) -> jbyteArray? {
   let book = makeAddressBook()
   log.info("getAddressBook: \(book)")

   let data = try! book.serializedData()
   log.info("getAddressBook data: \(data)")

   let array = data.withUnsafeBytes { (rawPtr: UnsafeRawBufferPointer) -> jbyteArray? in
      let ptr = rawPtr.bindMemory(to: Int8.self)
      if let baseAddress = ptr.baseAddress {
         var cdata = CData(data: baseAddress, count: UInt32(ptr.count))
         return data_SwiftToJava(env, &cdata)
      } else {
         return nil
      }
   }
   log.info("\(array)")
   return array
}
