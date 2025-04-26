import Foundation

@MainActor
final class CarViewModel: ObservableObject {
  @Published var allClass: [TypeClasses: [CarClass]] = [:]
  @Published var isLoading = false
  @Published var errorMessage = ""
  
  private var dataService: DataServiceProtocol
  
  init(service: DataServiceProtocol = DataService()) {
    self.dataService = service
  }
  
  func fetchAllClass(limit: Int) async {
    isLoading = true
    defer { isLoading = false }
    
    var tempData: [TypeClasses: [CarClass]] = [:]
    let limitedClass = Array(TypeClasses.allCases.prefix(limit))
    
    for typeClass in limitedClass {
      let result = await fetchData(cacheKey: typeClass)
      tempData[typeClass] = result
    }
    
    self.allClass = tempData
  }
  
  func clearCache() {
    dataService.clearCache()
    allClass = [:]
  }
  
  private func fetchData(cacheKey: TypeClasses) async -> [CarClass] {
    let url = MercedesAPI.getUrl(className: cacheKey)
    let header = MercedesAPI.headers
    
    if let cached: [CarClass] = dataService.loadFromCache(key: cacheKey.fullName, as: [CarClass].self) {
      print("Loaded \(cacheKey) from cache")
      return cached
    }
    
    do {
      let result: [CarClass] = try await dataService.fetch(url, header: header)
      dataService.saveToCache(result, key: cacheKey.fullName)
      print("Loaded from API")
      return result
    } catch {
      self.errorMessage = "Ошибка при загрузке \(cacheKey.fullName): \(error.localizedDescription)"
      print(error)
      return []
    }
  }
}
