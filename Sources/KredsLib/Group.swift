import Foundation

internal struct Group {
   let name: String
   let properties: [Property]

   init(name: String, properties: [Property]) {
      self.name = name
      self.properties = properties
   }
}

internal extension Group {
    static func array(fromDictionary dictionary: [String: Any]) -> [Group] {
        var groups: [Group] = []
        for (key, value) in dictionary {
            guard let values = value as? [String: Any] else { continue }
            let properties: [Property] = values.map({ (vars) -> Property in
                let (key, value) = vars
                return Property(name: key, value: value)
            })
            
            groups.append(Group(name: key, properties: properties))
        }
        return groups
    }
}
