internal protocol KredsGeneratorType {
    associatedtype T
    func generate(forGroup: Group) -> T
}
