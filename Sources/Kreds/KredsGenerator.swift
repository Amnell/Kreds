import Foundation

public struct KredsGenerator {
   private let infile: String

   init(infile: String) {
      self.infile = infile
   }

   internal static func generateGroup(name: String, properties: [String: Any]) -> Group {
      var propertyTypes: [Property] = []
      for (key, value) in properties {
         propertyTypes.append(Property(name: key, value: value))
      }
      return Group(name: name, properties: propertyTypes)
   }

   // func writeToFiles() {
   //    if let content = NSDictionary(contentsOfFile: infile) {
   //       var swiftFileRows: [String] = []
   //       swiftFileRows.append("struct Kreds {")
   //       for (key, value) in content {
   //          guard let key = key as? String else { continue }
   //          guard let values = value as? [String: Any] else { continue }
   //          swiftFileRows.append("\t" + KredsGenerator.generateSwiftStruct(name: key, properties: values).stringRepresentation())
   //       }
   //       swiftFileRows.append("}")
   //
   //       var objectiveCFileRows: [String] = []
   //       for (key, value) in content {
   //          guard let key = key as? String else { continue }
   //          guard let values = value as? [String: Any] else { continue }
   //          objectiveCFileRows.append(KredsGenerator.generateObjCConstants(name: key, properties: values))
   //       }
   //
   //       do {
   //          try swiftFileRows.joined(separator: "\n").write(toFile: outfileSwift, atomically: true, encoding: String.Encoding.utf8)
   //       }
   //       catch let e {
   //          print(e)
   //       }
   //
   //       do {
   //          try objectiveCFileRows.joined(separator: "\n").write(toFile: outfileObjectiveC, atomically: true, encoding: String.Encoding.utf8)
   //       }
   //       catch let e {
   //          print(e)
   //       }
   //    }
   // }

}
