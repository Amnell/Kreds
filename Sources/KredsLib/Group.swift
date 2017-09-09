import Foundation

internal struct Group {
   let name: String
   let properties: [Property]

   init(name: String, properties: [Property]) {
      self.name = name
      self.properties = properties
   }
}
