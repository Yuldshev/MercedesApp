import Foundation

enum MercedesAPI {
  static let baseURL = "https://api.mercedes-benz.com/configurator/v2"
  static let apiKey = "a0168cab-0ca1-4421-8ba0-14f95152f820"
  static let models = "vehicle-models"
  static let market = "markets/en_DE"
  static let type = "classes"
  
  static var headers: [String: String] {
    [
      "accept": "application/json",
                  "x-api-key": apiKey
    ]
  }
  
  static func getUrl(className: TypeClasses) -> URL {
    URL(string: "\(baseURL)/\(models)/\(market)/\(type)/\(className.fullName)")!
  }
}

enum TypeClasses: String, CaseIterable {
  case a, b, c, e, s, g, cle, gla, glb, glc, gle, gls, gt, sl
  
  var fullName: String {
    rawValue + "-class"
  }
}
