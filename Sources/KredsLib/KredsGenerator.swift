import Foundation

enum KredsGeneratorError: Error {
    case fileLoadFailed
}

public enum Language {
    case swift
    case objc
}

public struct KredsGenerator {
    private static func read(fileUrl: URL) throws -> [String: Any] {
        if let content = NSDictionary(contentsOf: fileUrl) as? [String: Any] {
            return content
        }
        else {
            throw KredsGeneratorError.fileLoadFailed
        }
    }
    
    public static func generate(sourceUrl: URL, destinationUrl: URL, languages: [Language]) throws {
        let dictionary = try KredsGenerator.read(fileUrl: sourceUrl)
        let groups = Group.array(fromDictionary: dictionary)
        
        print(destinationUrl.appendingPathComponent("Kreds.generated.swift", isDirectory: false))
        
        try languages.forEach { (language) in
            switch language {
            case .swift:
                try SwiftSourceGenerator.source(forGroups: groups)
                    .write(to: destinationUrl.appendingPathComponent("Kreds.generated.swift", isDirectory: false), atomically: true, encoding: String.Encoding.utf8)
            case .objc:
                try ObjectiveCSourceGenerator.source(forGroups: groups)
                    .write(to: destinationUrl.appendingPathComponent("Kreds.generated.h", isDirectory: false), atomically: true, encoding: String.Encoding.utf8)
            }
            
        }
    }
    
}
