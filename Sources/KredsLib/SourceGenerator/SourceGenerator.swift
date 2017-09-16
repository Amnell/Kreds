internal struct Tab {
    static let tabSpacing = 4
    static func level(_ level: Int = 0) -> String {
        return Array(repeating: " ", count: level * tabSpacing).joined()
    }
}

internal protocol KredsGeneratorType {
    associatedtype T
    static func source(forGroup: Group, tabLevel: Int) -> T
    static func source(forGroups: [Group], tabLevel: Int) -> T
}
