import Foundation
import FirebaseAuth

final class RegisterViewModel: ObservableObject {
  @Published var name = ""
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  
  @Published var message: AppMessage = .error("")
  
  private let service: FireStoreProtocol
  
  init(service: FireStoreProtocol = FireStoreService()) {
    self.service = service
  }
  
  func register() async {
    guard validate() else { return }
    
    do {
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      let userId = result.user.uid
      self.message = .success("Registration successful")
      await createUser(id: userId)
    } catch {
      self.message = .error("\(error.localizedDescription)")
    }
  }
  
  private func createUser(id: String) async {
    let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
    
    do {
      try await service.saveData(collection: "users", dataId: id, data: newUser)
    } catch {
      self.message = .error("\(error.localizedDescription)")
    }
  }
  
  private func validate() -> Bool {
    guard !name.trimmingCharacters(in: .whitespaces).isEmpty, !email.trimmingCharacters(in: .whitespaces).isEmpty,
      !password.trimmingCharacters(in: .whitespaces).isEmpty else {
      message = .error("Enter a valid Data")
      return false
    }
    
    guard email.contains("@") && email.contains(".") else {
      message = .error("Enter a valid Email")
      return false
    }
    
    guard password.count > 6 else {
      message = .error("Password length should be greater than 6")
      return false
    }
    
    guard password == confirmPassword else {
      message = .error("Password are not matching")
      return false
    }
    return true
  }
}
