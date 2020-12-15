import Foundation
import Logging

private let log = Logger(label: "serialization-tests")

@_cdecl("Java_com_home_helloNDK_SwiftLib_testSerialization")
func testSerialization() {
   let json = ["name": "Message from Swift serialization."]
   do {
      let data = try JSONSerialization.data(withJSONObject: json, options: [])
      struct Person: Decodable {
         let name: String
      }
      let person = try JSONDecoder().decode(Person.self, from: data)
      log.info("\(person.name)")
   } catch {
      log.info("\(String(describing: error))")
   }
}
