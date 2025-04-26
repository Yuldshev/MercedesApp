import Foundation

@MainActor
final class CarViewModel: ObservableObject {
  @Published var allClass: [TypeClasses: [CarClass]] = [:]
  @Published var isLoading = false
  @Published var message: AppMessage = .error("")
  
  private var dataService: DataServiceProtocol
  
  init(service: DataServiceProtocol = DataService()) {
    self.dataService = service
  }
  
  func fetchAllClass() async {
    guard allClass.isEmpty else { return }
    
    isLoading = true
    defer { isLoading = false }
    
    var tempData: [TypeClasses: [CarClass]] = [:]
    
    for typeClass in TypeClasses.allCases {
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
      self.message = .success("Load form Cache")
      return cached
    }
    
    do {
      let result: [CarClass] = try await dataService.fetch(url, header: header)
      dataService.saveToCache(result, key: cacheKey.fullName)
      self.message = .success("Load from API")
      return result
    } catch {
      self.message = .error("\(cacheKey.fullName): \(error.localizedDescription)")
      return []
    }
  }
}
