import Foundation
import FirebaseAuth

@MainActor
final class ProfileViewModel: ObservableObject {
  @Published var user: User?
  @Published var errorMessage = ""
  
  private let service: FireStoreProtocol
  
  init(service: FireStoreProtocol = FireStoreService()) {
    self.service = service
  }
  
  func fetchUser() async {
    guard let userId = Auth.auth().currentUser?.uid else {
      errorMessage = "User not authenticated"
      return
    }
    
    do {
      self.user = try await service.loadDocument(collection: "users", documentId: userId, as: User.self)
    } catch {
      self.errorMessage = error.localizedDescription
    }
  }
  
  func signOut() async {
    do {
      try Auth.auth().signOut()
      user = nil
    } catch {
      errorMessage = "Could not sign out"
    }
  }
}
