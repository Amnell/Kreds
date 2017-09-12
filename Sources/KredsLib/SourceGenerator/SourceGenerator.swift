internal struct Tab {
    static let tabSpacing = 4
    static func level(_ level: Int = 0) -> String {
        return Array(repeating: " ", count: level * tabSpacing).joined()
    }
}

internal protocol KredsGeneratorType {
    associatedtype T
    func source(forGroup: Group, tabLevel: Int) -> T
    func source(forGroups: [Group], tabLevel: Int) -> T
}
