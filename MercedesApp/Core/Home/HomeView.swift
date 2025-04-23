import SwiftUI

struct HomeView: View {
  @State private var selectedTab: Tab = .home
  
  init() { UITabBar.appearance().isHidden = true }
  
  var body: some View {
    ZStack {
      VStack {
        switch selectedTab {
          case .home:
            EmptyView()
          case .catalogue:
            EmptyView()
          case .favorite:
            EmptyView()
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
  HomeView()
}
