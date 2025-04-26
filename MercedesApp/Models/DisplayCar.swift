import Foundation

struct CarDisplay: Identifiable {
  let id = UUID()
  let name: String
  let body: String
  let price: Double
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

