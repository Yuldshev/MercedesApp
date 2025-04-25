import SwiftUI

struct HomeView: View {
  @StateObject private var vm = CarViewModel()
  
  var body: some View {
    VStack {
      
    }
    .navigationWithLarge(title: "Home")
    .task {
      await vm.fetchAllClass(limit: 1)
      print(vm.allClass)
    }
  }
}

#Preview {
  HomeView()
    .previewWithRouter()
}
