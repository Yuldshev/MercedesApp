import Foundation
import FirebaseAuth

@MainActor
final class ProfileViewModel: ObservableObject {
  @Published var user: User?
  @Published var message: AppMessage = .error("")
  
  private let service: FireStoreProtocol
  
  init(service: FireStoreProtocol = FireStoreService()) {
    self.service = service
  }
  
  func fetchUser() async {
    guard let userId = Auth.auth().currentUser?.uid else {
      message = .error("User not authenticated")
      return
    }
    
    do {
      self.user = try await service.loadDocument(collection: "users", documentId: userId, as: User.self)
    } catch {
      self.message = .error("\(error.localizedDescription)")
    }
  }
  
  func signOut() async {
    do {
      try Auth.auth().signOut()
      user = nil
    } catch {
      message = .error("Could not sign out")
    }
  }
}
