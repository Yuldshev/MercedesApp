import Foundation

protocol DataServiceProtocol {
  func fetch<T: Decodable>(_ url: URL, header: [String: String]) async throws -> T
  func saveToCache<T: Encodable>(_ data: T, key: String)
  func loadFromCache<T: Decodable>(key: String, as type: T.Type) -> T?
}

final class DataService: DataServiceProtocol {
  func fetch<T>(_ url: URL, header: [String : String]) async throws -> T where T : Decodable {
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    for (key, value) in header {
      request.setValue(value, forHTTPHeaderField: key)
    }
    
    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode(T.self, from: data)
  }
  
  func saveToCache<T>(_ data: T, key: String) where T : Encodable {
    if let encoded = try? JSONEncoder().encode(data) {
      UserDefaults.standard.set(encoded, forKey: key)
    }
  }
  
  func loadFromCache<T>(key: String, as type: T.Type) -> T? where T : Decodable {
    guard let data = UserDefaults.standard.data(forKey: key),
          let decoded = try? JSONDecoder().decode(T.self, from: data) else {
      return nil
    }
    return decoded
  }
  
}
