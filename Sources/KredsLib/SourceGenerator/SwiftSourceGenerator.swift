import Foundation

internal struct SwiftSourceGenerator: KredsGeneratorType {
    func source(forGroup: Group, tabLevel level: Int = 0) -> String {
        var strings: [String] = []
        strings.append(Tab.level(level) + "struct \(forGroup.name) {")
        forGroup.properties.forEach({
            strings.append(self.source(property: $0, forGroup: forGroup, tabLevel: level + 1))
        })
        strings.append(Tab.level(level) + "}")
        return strings.joined(separator: "\n")
    }
    
    func source(forGroups groups: [Group], tabLevel level: Int = 0) -> String {
        var strings: [String] = []
        strings.append(Tab.level(level) + "struct Kreds {")
        groups.forEach({
            strings.append(self.source(forGroup: $0, tabLevel: level + 1))
        })
        strings.append(Tab.level(level) + "}")
        return strings.joined(separator: "\n\n")
    }

    func source(property: Property, forGroup group: Group, tabLevel level: Int = 0) -> String {
        return Tab.level(level) + "static let \(property.name.toSwiftVariableName()) = \"\(property.value)\""
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
