import SwiftUI

struct FavoriteView: View {
  @EnvironmentObject var vm: FavoriteViewModel
  @Environment(\.router) var router
  
  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      LazyVGrid(columns: columns, spacing: 16) {
        ForEach(vm.favorites) { car in
          Button {
            router.showScreen(.push) { _ in
              CarDetailView(car: car)
                .environmentObject(vm)
                .navigationWithInline(title: "")
            }
          } label: {
            CarModelCartView(car: car)
          }
        }
      }
      .padding(.horizontal, 24)
    }
    .frame(maxHeight: .infinity)
    .background(.appLightGray)
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
