import Foundation

extension CarViewModel {
  func getDisplayCar() -> [CarDisplay] {
    var result: [String: CarDisplay] = [:]
    
    for(_, carClasses) in allClass {
      for carClass in carClasses {
        for bodyType in carClass.bodytypes {
          for model in bodyType.models {
            for vehical in model.vehicles {
              let id = vehical.name
              
              if result[id] != nil { continue }
              
              let finance = vehical.financeData.prices.automatic.price
              let engine = vehical.technicalData.engine
              let body = vehical.technicalData.body
              
              let dimensions = body?.dimensions
              let weight = body?.weights?.weightsAutomatic
              
              let display = CarDisplay(
                name: vehical.name.removingText(),
                body: vehical.bodytypeName,
                price: finance,
                topSpeed: engine?.topSpeed?.formatted ?? "n/a",
                powerHp: engine?.combinedPowerInHp?.formatted ?? engine?.combustionEngine?.powerInHp?.formatted ?? "n/a",
                torque: engine?.combinedTorque?.formatted ?? engine?.combustionEngine?.torque?.formatted ?? "n/a",
                lenght: dimensions?.length?.formatted ?? "n/a",
                width: dimensions?.width?.formatted ?? "n/a",
                height: dimensions?.height?.formatted ?? "n/a",
                wheelBase: dimensions?.wheelBase?.formatted ?? "n/a",
                weight: weight?.weightMax?.formatted ?? "n/a",
                imageURL: vehical.images?.stage
              )
              result[id] = display
            }
          }
        }
      }
    }
    
    return Array(result.values)
  }
}

