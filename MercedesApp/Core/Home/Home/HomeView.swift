import SwiftUI

struct HomeView: View {
  @EnvironmentObject var vm: CarViewModel
  
  var categories: [CarDisplayCategory] {
    vm.getDisplayCategories()
  }
  
  var body: some View {
    List {
      
    }
    .navigationWithLarge(title: "Home")
    .task {
      await vm.fetchAllClass()
    }
  }
}

#Preview {
  HomeView()
    .environmentObject(CarViewModel())
    .previewWithRouter()
}
