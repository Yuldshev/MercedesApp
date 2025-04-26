import SwiftUI

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
              .environmentObject(vmCar)
              .environmentObject(vmLike)
          case .catalogue:
            CatalogView()
              .environmentObject(vmCar)
              .environmentObject(vmLike)
          case .favorite:
            FavoriteView()
              .environmentObject(vmCar)
              .environmentObject(vmLike)
          case .profile:
            ProfileView()
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
