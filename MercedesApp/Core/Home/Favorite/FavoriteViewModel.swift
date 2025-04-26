import Foundation

@MainActor
final class FavoriteViewModel: ObservableObject {
  @Published private(set) var favorites: [CarDisplay] = []
  
  private let service: FavoriteServiceProtocol
  
  init(service: FavoriteServiceProtocol = FavoriteService()) {
    self.service = service
    self.favorites = service.loadFavorites()
  }
  
  func addFavorite(_ car: CarDisplay) {
    guard !isFavorite(car) else { return }
    favorites.append(car)
    service.saveFavorites(favorites)
  }
  
  func removeFavorite(_ car: CarDisplay) {
    favorites.removeAll { $0.id == car.id }
    service.saveFavorites(favorites)
  }
  
  func isFavorite(_ car: CarDisplay) -> Bool {
    favorites.contains(where: { $0.id == car.id })
  }
}
