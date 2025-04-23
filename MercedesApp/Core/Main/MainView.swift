import SwiftUI
import SwiftfulRouting

struct MainView: View {
  @StateObject private var appState = AppState()
  
  var body: some View {
    RouterView { _ in
      switch appState.currentRoute {
        case .splash: SplashView()
        case .login: AuthView()
        case .home: DelegateView()
      }
    }
    .id(appState.currentUserId)
  }
}

#Preview {
  MainView().environmentObject(AppState())
}
