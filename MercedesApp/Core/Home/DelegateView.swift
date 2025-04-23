import SwiftUI

struct DelegateView: View {
  @State private var selectedTab: Tab = .home
  
  init() { UITabBar.appearance().isHidden = true }
  
  var body: some View {
    ZStack {
      VStack {
        switch selectedTab {
          case .home:
            HomeView()
          case .catalogue:
            CatalogView()
          case .favorite:
            FavoriteView()
          case .profile:
            ProfileView()
        }
      }
      
      VStack {
        Spacer()
        CustomTabView(selectedTab: $selectedTab)
      }
    }
  }
}

#Preview {
  DelegateView()
    .previewWithRouter()
}
