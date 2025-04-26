import SwiftUI

extension String {
  func removingText() -> String {
    let keywords = ["Compact", "Compact Saloon", "Saloon"]
    var cleaned = self
    for keyword in keywords {
      cleaned = cleaned.replacingOccurrences(of: keyword, with: "", options: .caseInsensitive)
    }
    
    return cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
