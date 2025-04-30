import Foundation

extension CarViewModel {
  func filterCars(by seach: String) -> [CarDisplay] {
    guard !seach.isEmpty else {
      return getClasses().flatMap { $0.cars }
    }
    
    let lowercasedSearch = seach.lowercased()
    
    return getClasses()
      .flatMap { $0.cars }
      .filter { car in
        car.name.lowercased().contains(lowercasedSearch)
      }
  }
}
