import Foundation
import _PhotosUI_SwiftUI
import FirebaseAuth

@MainActor
final class ProfileViewModel: ObservableObject {
  @Published var user: User?
  @Published var isLoading = false
  
  @Published var message: AppMessage = .error("")
  
  private let service: FireStoreProtocol
  private let storage: StorageProtocol
  
  init(service: FireStoreProtocol = FireStoreService(), storage: StorageProtocol = StorageService()) {
    self.service = service
    self.storage = storage
  }
  
  func fetchUser() async {
    guard let userId = Auth.auth().currentUser?.uid else {
      message = .error("User not authenticated")
      return
    }
    
    isLoading = true
    defer { isLoading = false }
    
    do {
      self.user = try await service.loadDocument(collection: "users", documentId: userId, as: User.self)
    } catch {
      self.message = .error("\(error.localizedDescription)")
    }
  }
  
  func uploadAvatar(from item: PhotosPickerItem?) async {
    guard let item = item else { return }
    
    do {
      guard let data = try await item.loadTransferable(type: Data.self) else { return }
      guard let userId = Auth.auth().currentUser?.uid else { return }
      
      let url = try await storage.uploadImage(data: data, path: "profileAvatar/\(userId)")
      
      try await service.saveData(collection: "users", dataId: userId, data: ["profileImageURL:": url.absoluteString])
      await fetchUser()
    } catch {
      message = .error("Upload failed: \(error.localizedDescription)")
      message = .success("Avatar uploaded successfully.")
      print(error)
    }
  }
  
  func signOut() async {
    do {
      try Auth.auth().signOut()
      user = nil
    } catch {
      message = .error("Could not sign out: \(error.localizedDescription)")
    }
  }
}
