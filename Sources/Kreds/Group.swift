import Foundation

internal struct Group {
   let name: String
   let properties: [Property]

   init(name: String, properties: [Property]) {
      self.name = name.toSwiftStructName()
      self.properties = properties
   }
}

extension Group {
   func stringRepresentation(forLanguage language: Language) -> String {
      switch language {
      case .swift: return self.swiftStringRepresentation()
      case .objc: return self.objcStringRepresentation()
      }
   }

   private func swiftStringRepresentation() -> String {
      var strings: [String] = []
      strings.append("struct \(name) {")
      properties.forEach({
         let stringRepresentation = $0.stringRepresentation(inGroup: self, forLanguage: Language.swift)
         strings.append("   \(stringRepresentation)")
      })
      strings.append("}")
      return strings.joined(separator: "\n")
   }

   private func objcStringRepresentation() -> String {
      var strings: [String] = []
      strings.append("// \(self.name)")
      properties.forEach({
         let stringRepresentation = $0.stringRepresentation(inGroup: self, forLanguage: Language.objc)
         strings.append("\(stringRepresentation)")
      })
      return strings.joined(separator: "\n")
   }
}
