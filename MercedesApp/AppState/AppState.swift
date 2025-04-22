import Foundation

enum AppRoute {
  case splash, login, home
}

final class AppState: ObservableObject {
  @Published var currentRoute: AppRoute = .splash
  
  init() { showSplash() }
  
  private func showSplash() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.checkAuth()
    }
  }
  
  private func checkAuth() {
    self.currentRoute = .login
  }
}
