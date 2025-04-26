import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol FavoriteServiceProtocol {
  func loadFavorites() -> [CarDisplay]
  func saveFavorites(_ cars: [CarDisplay])
  
  func uploadCloud(_ cars: [CarDisplay]) async throws
  func loadCloud() async throws -> [CarDisplay]
}

final class FavoriteService: FavoriteServiceProtocol {
  private let key = "favorite_cars"
  private let db = Firestore.firestore()
  
  private var userId: String? {
    Auth.auth().currentUser?.uid
  }
  
  func loadFavorites() -> [CarDisplay] {
    guard let data = UserDefaults.standard.data(forKey: key), let cars = try? JSONDecoder().decode([CarDisplay].self, from: data) else {
      return []
    }
    return cars
  }
  
  func saveFavorites(_ cars: [CarDisplay]) {
    if let data = try? JSONEncoder().encode(cars) {
      UserDefaults.standard.set(data, forKey: key)
    }
  }
  
  func uploadCloud(_ cars: [CarDisplay]) async throws {
    guard let userId else {
      throw NSError(domain: "No userID", code: 0)
    }
    
    let ref = db.collection("favorites").document(userId)
    try await ref.setData([
      "cars": try cars.map { try Firestore.Encoder().encode($0) }
    ])
  }
  
  func loadCloud() async throws -> [CarDisplay] {
    guard let userId else {
      throw NSError(domain: "No userID", code: 0)
    }
    
    let doc = try await db.collection("favorites").document(userId).getDocument()
    
    guard let data = doc.data(),
          let carsData = data["cars"] as? [[String: Any]] else {
      return []
    }
    
    return try carsData.map {dict in
      let jsonData = try JSONSerialization.data(withJSONObject: dict)
      return try JSONDecoder().decode(CarDisplay.self, from: jsonData)
    }
  }
}

