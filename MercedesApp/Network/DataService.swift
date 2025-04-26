import Foundation
import Alamofire

protocol DataServiceProtocol {
  func fetch<T: Decodable>(_ url: URL, header: [String: String]) async throws -> T
  func saveToCache<T: Encodable>(_ data: T, key: String)
  func loadFromCache<T: Decodable>(key: String, as type: T.Type) -> T?
  func clearCache()
}

final class DataService: DataServiceProtocol {
  func fetch<T>(_ url: URL, header: [String : String]) async throws -> T where T : Decodable {
    let headers = HTTPHeaders(header)
    
    return try await withCheckedThrowingContinuation { continuation in
      AF.request(url, method: .get, headers: headers)
        .validate()
        .responseDecodable(of: T.self) { response in
          switch response.result {
            case .success(let decodedData):
              continuation.resume(returning: decodedData)
            case .failure(let error):
              continuation.resume(throwing: error)
          }
        }
    }
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
  
  func clearCache() {
    let keys = TypeClasses.allCases.map { $0.fullName }
    for key in keys {
      UserDefaults.standard.removeObject(forKey: key)
    }
  }
}
