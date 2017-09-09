import Foundation

internal struct Property {
   let name: String
   let value: Any

   init(name: String, value: Any) {
      self.name = name
      self.value = value
   }
}
