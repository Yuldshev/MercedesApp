import SwiftUI
import Pow

struct DelegateView: View {
  @State private var selectedTab: Tab = .home
  @StateObject private var vmCar = CarViewModel()
  @StateObject private var vmLike = FavoriteViewModel()
  
  init() { UITabBar.appearance().isHidden = true }
  
  var body: some View {
    ZStack {
      VStack {
        switch selectedTab {
          case .home:
            HomeView()
              .transition(.movingParts.wipe(edge: .bottom, blurRadius: 50))
              .environmentObject(vmCar)
              .environmentObject(vmLike)
          case .catalogue:
            CatalogView()
              .transition(.movingParts.wipe(edge: .bottom, blurRadius: 50))
              .environmentObject(vmCar)
              .environmentObject(vmLike)
          case .favorite:
            FavoriteView()
              .transition(.movingParts.wipe(edge: .bottom, blurRadius: 50))
              .environmentObject(vmLike)
          case .profile:
            ProfileView()
              .transition(.movingParts.wipe(edge: .bottom, blurRadius: 50))
        }
      }
      
      VStack {
        Spacer()
        CustomTabView(selectedTab: $selectedTab)
      }
    }
    .task {
      await vmCar.fetchAllClass()
    }
  }
}

#Preview {
  DelegateView()
    .previewWithRouter()
}
