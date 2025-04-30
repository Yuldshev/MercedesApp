import SwiftUI

struct CatalogView: View {
  @EnvironmentObject var vm: CarViewModel
  @EnvironmentObject var vmFav: FavoriteViewModel
  @Environment(\.router) var router
  
  var filteredCars: [CarDisplayCategory] {
    vm.getClasses()
  }
  
  private let columns = [
    GridItem(.flexible(), spacing: 8),
    GridItem(.flexible(), spacing: 8)
  ]
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      Text("Mercedes Classes")
        .font(.corporateAMedium(size: 34))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 24)
      
      LazyVGrid(columns: columns, spacing: 8) {
        ForEach(filteredCars) { category in
          Button {
            print(category)
            router.showScreen(.push) { _ in
              CarModelView(cars: category.cars)
                .environmentObject(vmFav)
                .navigationWithInline(title: category.className)
            }
          } label: {
            CatalogClassView(className: category)
              .frame(maxWidth: .infinity)
              .frame(height: 200)
          }
        }
      }
      .padding(.horizontal, 24)
      .onChange(of: vm.message) { _, new in
        switch new {
          case .error(let text):
            router.showErrorModal(message: text)
          case .success(let text):
            router.showSuccessModal(message: text)
        }
      }
            
      .task {
        await vm.fetchAllClass()
      }
    }
  }
}


#Preview {
  CatalogView()
    .environmentObject(CarViewModel())
    .environmentObject(FavoriteViewModel())
    .previewWithRouter()
}
