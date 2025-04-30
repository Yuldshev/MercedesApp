import Foundation

extension TimeInterval {
  func formatterDate(style: DateFormatter.Style = .short, locate: Locale = .current) -> String {
    let date = Date(timeIntervalSince1970: self)
    let formatter = DateFormatter()
    formatter.dateStyle = style
    formatter.timeStyle = .none
    formatter.locale = locate
    return formatter.string(from: date)
  }
}
