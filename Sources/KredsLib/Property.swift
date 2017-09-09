import Foundation

internal struct Property {
    let name: String
    let value: Any
    
    init(name: String, value: Any) {
        self.name = name
        self.value = value
    }
}

extension Property {
    func stringRepresentation(inGroup group: Group, forLanguage language: Language) -> String {
        switch language {
        case .swift: return "static let \(name.toSwiftVariableName()) = \"\(value)\""
        case .objc:
            let constName = "\(group.name) \(name)".toObjCConstName()
            return "NSString *const \(constName) = @\"\(value)\";"
        }
    }
}
