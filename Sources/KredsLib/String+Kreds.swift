import Foundation

internal extension String {
    
   func uppercaseFirstLetter() -> String {
      return String.uppercasedFirstLetter(self)
   }

   func lowercaseFirstLetter() -> String {
      return String.lowercasingFirstLetter(self)
   }

   static func uppercasedFirstLetter(_ string: String) -> String {
      let first = String(string.characters.prefix(1)).capitalized
      let other = String(string.characters.dropFirst())
      return first + other
   }

   static func lowercasingFirstLetter(_ string: String) -> String {
      let first = String(string.characters.prefix(1)).lowercased()
      let other = String(string.characters.dropFirst())
      return first + other
   }

   static func stripSpaces(_ string: String) -> String {
      return string.replacingOccurrences(of: " ", with: "")
   }

}
