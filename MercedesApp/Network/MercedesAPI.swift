import Foundation

enum MercedesAPI {
  static let baseURL = "https://api.mercedes-benz.com/configurator/v2"
  static let apiKey = "433c784e-ac9f-46e3-bc7e-c3b6f0165df2"
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
  case a, b, c, e, s, g, cla, cle, gla, glb, glc, gle, gls, gt, sl
  
  var fullName: String {
    rawValue + "-class"
  }
}
