import Foundation

struct CarDisplay: Identifiable, Codable {
  var id: String { name }
  
  let name: String
  let body: String
  let price: String
  let topSpeed: String
  let powerHp: String
  let torque: String
  let lenght: String
  let width: String
  let height: String
  let wheelBase: String
  let weight: String
  let imageURL: URL?
}

struct CarDisplayCategory: Identifiable {
  let id = UUID()
  let className: String
  let cars: [CarDisplay]
}
