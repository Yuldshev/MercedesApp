import Foundation
import FirebaseAuth

@MainActor
final class SignInViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var errorMessage = ""
  
  func login() async {
    guard validate() else { return }
    do {
      let _ = try await Auth.auth().signIn(withEmail: email, password: password)
      print("Success auth")
    } catch {
      self.errorMessage = error.localizedDescription
    }
  }
  
  func validate() -> Bool {
    guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
      errorMessage = "Enter a valid Email/Password"
      return false
    }
    
    guard email.contains("@") && email.contains(".") else {
      errorMessage = "Enter a valid Email"
      return false
    }
    return true
  }
}
