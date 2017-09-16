import Foundation

internal struct ObjectiveCSourceGenerator: KredsGeneratorType {
    static func source(forGroup group: Group, tabLevel level: Int = 0) -> String {
        var strings: [String] = []
        strings.append("// \(group.name)")
        group.properties.forEach({
           strings.append(self.source(property: $0, forGroup: group))
        })
        return strings.joined(separator: "\n")
    }

    static func source(forGroups groups: [Group], tabLevel level: Int = 0) -> String {
        var strings: [String] = []
        groups.forEach({
            strings.append(self.source(forGroup: $0))
        })
        return strings.joined(separator: "\n\n")
    }

    static func source(property: Property, forGroup group: Group, tabLevel level: Int = 0) -> String {
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
