import Foundation

extension CarViewModel {
  func filterCars(by seach: String) -> [CarDisplayCategory] {
    guard !seach.isEmpty else {
      return getClasses()
    }
    
    let lowercasedSearch = seach.lowercased()
    
    let allClasses = getClasses()
    var filteredClasses: [CarDisplayCategory] = []
    
    for classes in allClasses {
      let filteredCars = classes.cars.filter { car in
        car.name.lowercased().contains(lowercasedSearch)
      }
      
      if !filteredCars.isEmpty {
        let newClass = CarDisplayCategory(className: classes.className, cars: filteredCars)
        filteredClasses.append(newClass)
      }
    }
    return filteredClasses
  }
}
