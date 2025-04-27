import SwiftUI

struct FavoriteView: View {
  @EnvironmentObject var vm: FavoriteViewModel
  @Environment(\.router) var router
  
  var body: some View {
    VStack {
      List(vm.favorites) { item in
        Text(item.name)
      }
      .listStyle(.plain)
    }
    .navigationWithLarge(title: "Favorite List")
    .onChange(of: vm.message) { _, new in
      switch new {
        case .error(let text):
          router.showErrorModal(message: text)
        case .success(let text):
          router.showSuccessModal(message: text)
      }
    }
  }
}

#Preview {
  FavoriteView()
    .environmentObject(FavoriteViewModel())
    .previewWithRouter()
}
