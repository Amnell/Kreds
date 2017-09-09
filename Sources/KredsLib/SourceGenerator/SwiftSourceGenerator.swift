import Foundation

internal struct SwiftSourceGenerator: KredsGeneratorType {
    func generate(forGroup: Group) -> String {
        var strings: [String] = []
        strings.append("struct \(forGroup.name) {")
        forGroup.properties.forEach({
           strings.append("    " + self.generate(property: $0, forGroup: forGroup))
        })
        strings.append("}")
        return strings.joined(separator: "\n")
    }

    func generate(property: Property, forGroup group: Group) -> String {
        return "static let \(property.name.toSwiftVariableName()) = \"\(property.value)\""
    }
}

internal extension String {

   func toSwiftStructName() -> String {
      return self.split(separator: " ")
         .map(String.init)
         .map({ $0.uppercaseFirstLetter() })
         .joined(separator: "")
   }

   func toSwiftVariableName() -> String {
      let name = self.split(separator: " ")
         .map(String.init)
         .map(String.uppercasedFirstLetter)
         .joined(separator: "")

      return String.lowercasingFirstLetter(name)
   }

}
