import Foundation

internal struct ObjectiveCSourceGenerator: KredsGeneratorType {
    func generate(forGroup: Group) -> String {
        var strings: [String] = []
        strings.append("// \(forGroup.name)")
        forGroup.properties.forEach({
           strings.append(self.generate(property: $0, forGroup: forGroup))
        })
        return strings.joined(separator: "\n")
    }

    func generate(property: Property, forGroup group: Group) -> String {
        let constName = "\(group.name) \(property.name)".toObjCConstName()
        return "NSString *const \(constName) = @\"\(property.value)\";"
    }
}

internal extension String {

    func toObjCConstName() -> String {
      let name = self.split(separator: " ")
         .map(String.init)
         .map(String.uppercasedFirstLetter)
         .joined(separator: "")
      return "k" + name
    }

}
