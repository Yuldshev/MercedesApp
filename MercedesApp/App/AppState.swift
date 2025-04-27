import Foundation
import FirebaseAuth
import SwiftUI

enum AppRoute {
  case splash, login, home
}

@MainActor
final class AppState: ObservableObject {
  @Published var currentRoute: AppRoute = .splash
  @Published var currentUserId = ""
  
  private var handler: AuthStateDidChangeListenerHandle?
  
  var authStatus: Bool {
    return !currentUserId.isEmpty
  }
  
  init() {
    setupFirebaseAuthListener()
  }
  
  deinit {
    if let handler = handler {
      Auth.auth().removeStateDidChangeListener(handler)
    }
  }
  
  private func setupFirebaseAuthListener() {
    handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self else {
        return
      }
      self.currentUserId = user?.uid ?? ""
      Task {
        await self.showSplashAndNavigate()
        await self.updateRouteBasedOnAuth()
      }
    }
  }
  
  private func showSplashAndNavigate() async {
    currentRoute = .splash
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    let isSignIn = Auth.auth().currentUser != nil
    await updateRouteBasedOnAuth(isSignedIn: isSignIn)
  }
  
  private func updateRouteBasedOnAuth(isSignedIn: Bool? = nil) async {
    let authStatus = isSignedIn ?? self.authStatus
    withAnimation {
      currentRoute = authStatus ? .home : .login
    }
  }
}
