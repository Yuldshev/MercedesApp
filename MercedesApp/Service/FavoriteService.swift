import Foundation

protocol FavoriteServiceProtocol {
  func loadFavorites() -> [CarDisplay]
  func saveFavorites(_ cars: [CarDisplay])
}

final class FavoriteService: FavoriteServiceProtocol {
  private let key = "favorite_cars"
  
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
}

