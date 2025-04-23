import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class ProfileViewModel: ObservableObject {
  @Published var user: User?
  @Published var errorMessage = ""
  
  init() {
    Task {
      await fetchUser()
    }
  }
  
  func fetchUser() async {
    guard let userId = Auth.auth().currentUser?.uid else { return }
    
    do {
      let document = try await Firestore.firestore()
        .collection("users")
        .document(userId)
        .getDocument()
      
      guard let data = document.data() else { return }
      
      self.user = User(
        id: data["id"] as? String ?? "",
        name: data["name"] as? String ?? "",
        email: data["email"] as? String ?? "",
        joined: data["joined"] as? TimeInterval ?? 0
      )
    } catch {
      self.errorMessage = error.localizedDescription
    }
  }
  
  func signOut() async {
    do {
      try Auth.auth().signOut()
    } catch {
      errorMessage = "Could not sign out"
    }
  }
}
