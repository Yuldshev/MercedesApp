import Foundation
import FirebaseAuth

@MainActor
final class LoginViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var message: AppMessage = .error("")
  
  func login() async {
    guard validate() else { return }
    do {
      let _ = try await Auth.auth().signIn(withEmail: email, password: password)
      message = .success("Successfully Logged In")
    } catch {
      self.message = .error("\(error.localizedDescription)")
    }
  }
  
  func validate() -> Bool {
    guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.trimmingCharacters(in: .whitespaces).isEmpty else {
      message = .error("Enter a valid Email/Password")
      return false
    }
    
    guard email.contains("@") && email.contains(".") else {
      message = .error("Enter a valid Email")
      return false
    }
    return true
  }
}
