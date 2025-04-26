import Foundation

extension CarViewModel {
  func getDisplayCategories() -> [CarDisplayCategory] {
    var categories: [String: [CarDisplay]] = [:]
    
    for (_, carClasses) in allClass {
      for carClass in carClasses {
        var cars: [CarDisplay] = []
        
        for bodyType in carClass.bodytypes {
          for model in bodyType.models {
            for vehicle in model.vehicles {
              let finance = vehicle.financeData.prices.automatic.price
              let engine = vehicle.technicalData.engine
              let body = vehicle.technicalData.body
              let dimensions = body?.dimensions
              let weight = body?.weights?.weightsAutomatic
              
              let car = CarDisplay(
                name: vehicle.name.removingText,
                body: bodyType.bodytypeName,
                price: finance.formattedPrice,
                topSpeed: engine?.topSpeed?.value.formattedTopSpeed ?? "n/a",
                powerHp: engine?.combinedPowerInHp?.value.formattedHP ?? engine?.combustionEngine?.powerInHp?.value.formattedHP ?? "n/a",
                torque: engine?.combinedTorque?.value.formattedTorque ?? engine?.combustionEngine?.torque?.value.formattedTorque ?? "n/a",
                lenght: dimensions?.length?.value.formattedDimensions ?? "n/a",
                width: dimensions?.width?.value.formattedDimensions ?? "n/a",
                height: dimensions?.height?.value.formattedDimensions ?? "n/a",
                wheelBase: dimensions?.wheelBase?.value.formattedDimensions ?? "n/a",
                weight: weight?.weightMax?.value.formattedDimensions ?? "n/a",
                imageURL: vehicle.images?.stage
              )
              
              cars.append(car)
            }
          }
        }
        
        if !cars.isEmpty {
          if categories[carClass.className] != nil {
            categories[carClass.className]?.append(contentsOf: cars)
          } else {
            categories[carClass.className] = cars
          }
        }
      }
    }
    
    let result = categories.map { CarDisplayCategory(className: $0.key, cars: $0.value) }
    return result.sorted { $0.className < $1.className }
  }
}
