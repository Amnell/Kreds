#!/usr/bin/swift

import Foundation

guard CommandLine.arguments.count == 4 else { fatalError("Please provide infile outfileSwift and outfileObjectiveC") }

let infile = CommandLine.arguments[1]
let outfileSwift = CommandLine.arguments[2]
let outfileObjectiveC = CommandLine.arguments[3]

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    func lowercasingFirstLetter() -> String {
        let first = String(characters.prefix(1)).lowercased()
        let other = String(characters.dropFirst())
        return first + other
    }

    mutating func lowercaseFirstLetter() {
        self = self.lowercasingFirstLetter()
    }
}

func generateSwiftStruct(name: String, properties: [String: Any]) -> String {
    var rows: [String] = []
    rows.append("struct \(name) {")
        for (key, value) in properties {
            guard let value = value as? String else { continue }
            rows.append("\t\tstatic let \(key.lowercasingFirstLetter()) = \"\(value)\"")
        }
    rows.append("\t}")

    return rows.joined(separator: "\n")
}

func generateObjCConstants(name: String, properties: [String: Any]) -> String {
    var rows: [String] = []
    for (key, value) in properties {
        guard let value = value as? String else { continue }
        rows.append("NSString *const k\(name)\(key) = @\"\(value)\";")
    }
    return rows.joined(separator: "\n")
}

let fileManager = FileManager()
if let content = NSDictionary(contentsOfFile: infile) {
    var swiftFileRows: [String] = []
    swiftFileRows.append("struct Constants {")
    for (key, value) in content {
        guard let key = key as? String else { continue }
        guard let values = value as? [String: Any] else { continue }
        swiftFileRows.append("\t" + generateSwiftStruct(name: key, properties: values))
        // print("\t" + generateObjCConstants(name: key, properties: values))
    }
    swiftFileRows.append("}")

    var objectiveCFileRows: [String] = []
    for (key, value) in content {
        guard let key = key as? String else { continue }
        guard let values = value as? [String: Any] else { continue }
        objectiveCFileRows.append(generateObjCConstants(name: key, properties: values))
    }

    do {
        try swiftFileRows.joined(separator: "\n").write(toFile: outfileSwift, atomically: true, encoding: String.Encoding.utf8)
    }
    catch let e {
        print(e)
    }

    do {
        try objectiveCFileRows.joined(separator: "\n").write(toFile: outfileObjectiveC, atomically: true, encoding: String.Encoding.utf8)
    }
    catch let e {
        print(e)
    }
}
