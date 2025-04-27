import SwiftUI
import SwiftfulRouting

struct MainView: View {
  @StateObject private var appState = AppState()
  
  var body: some View {
    RouterView { _ in
      switch appState.currentRoute {
        case .splash: SplashView().transition(.blurReplace)
        case .login: AuthView().transition(.blurReplace)
        case .home: DelegateView().transition(.blurReplace)
      }
    }
    .id(appState.currentUserId)
  }
}

#Preview {
  MainView().environmentObject(AppState())
}
