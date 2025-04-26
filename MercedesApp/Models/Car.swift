import Foundation

struct CarClass: Identifiable, Codable {
  let classId: String
  let className: String
  let bodytypes: [BodyType]
  
  var id: String { classId }
}

struct BodyType: Codable, Identifiable {
  let bodytypeId: String
  let bodytypeName: String
  let models: [Models]
  
  var id: String { bodytypeId }
}

struct Models: Codable {
  let vehicles: [Vehicles]
}

struct Vehicles: Codable, Identifiable {
  let bodytypeName: String
  let name: String
  let modelYear: String
  let financeData: FinanceData
  let technicalData: TechnicalData
  let images: Images?
  
  var id: String { bodytypeName }
}

//MARK: -  FinanceData
struct FinanceData: Codable {
  let prices: Prices
}

struct Prices: Codable {
  let automatic: PriceAutomatic
}

struct PriceAutomatic: Codable {
  let price: Double
}

//MARK: - TechnicalData
struct TechnicalData: Codable {
  let engine: Engine?
  let body: Body?
}

struct Engine: Codable {
  let topSpeed: MeasurementValue?
  let combinedPowerInHp: MeasurementValue?
  let combinedTorque: MeasurementValue?
  let combustionEngine: CombustionEngine?
}

struct CombustionEngine: Codable {
  let powerInHp: MeasurementValue?
  let torque: MeasurementValue?
}

struct Body: Codable {
  let dimensions: Dimensions?
  let weights: Weights?
}

struct Dimensions: Codable {
  let length: MeasurementValue?
  let width: MeasurementValue?
  let height: MeasurementValue?
  let wheelBase: MeasurementValue?
}

struct Weights: Codable {
  let weightsAutomatic: WeightsAutomatic?
  
  enum CodableKeys: String, CodingKey {
    case weightsAutomatic = "automatic"
  }
}

struct WeightsAutomatic: Codable {
  let weightMax: MeasurementValue?
}

//MARK: - Images
struct Images: Codable {
  let stage: URL?
}

//MARK: - Help Struct
struct MeasurementValue: Codable {
  let value: Int
}
