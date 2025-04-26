import Foundation

@MainActor
final class FavoriteViewModel: ObservableObject {
  @Published private(set) var favorites: [CarDisplay] = []
  @Published var errorMessage = ""
  
  private let service: FavoriteServiceProtocol
  
  init(service: FavoriteServiceProtocol = FavoriteService()) {
    self.service = service
    self.favorites = service.loadFavorites()
    
    Task {
      await syncCloud()
    }
  }
  
  func addFavorite(_ car: CarDisplay) {
    guard !isFavorite(car) else { return }
    favorites.append(car)
    service.saveFavorites(favorites)
    
    Task {
      try? await service.uploadCloud(favorites)
    }
  }
  
  func removeFavorite(_ car: CarDisplay) {
    favorites.removeAll { $0.id == car.id }
    service.saveFavorites(favorites)
    
    Task {
      try? await service.uploadCloud(favorites)
    }
  }
  
  func isFavorite(_ car: CarDisplay) -> Bool {
    favorites.contains(where: { $0.id == car.id })
  }
  
  func syncCloud() async {
    do {
      self.favorites = try await service.loadCloud()
      service.saveFavorites(favorites)
    } catch {
      self.errorMessage = error.localizedDescription
    }
  }
}
