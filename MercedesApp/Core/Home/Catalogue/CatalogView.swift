import SwiftUI

struct CatalogView: View {
  @EnvironmentObject var vm: CarViewModel
  @EnvironmentObject var vmFav: FavoriteViewModel
  @Environment(\.router) var router
  
  var filteredCars: [CarDisplayCategory] {
    vm.getClasses()
  }
  
  var body: some View {
    VStack {
      List {
        ForEach(filteredCars) { name in
          Button(name.className) {
            router.showScreen(.push) { _ in
              CarListView(cars: name.cars)
                .environmentObject(vmFav)
            }
          }
        }
      }
    }
    .navigationWithLarge(title: "Catalogue")
    .onChange(of: vm.message) { _, new in
      switch new {
        case .error(let text):
          router.showErrorModal(message: text)
        case .success(let text):
          router.showSuccessModal(message: text)
      }
    }
    .onChange(of: vmFav.message) { _, new in
      switch new {
        case .error(let text):
          router.showErrorModal(message: text)
        case .success(let text):
          router.showSuccessModal(message: text)
      }
    }
    
    //TODO: - DELETE COMPLETE
    .task {
      await vm.fetchAllClass()
    }
  }
}

struct CarListView: View {
  @EnvironmentObject var vmFav: FavoriteViewModel
  @Environment(\.router) var router
  let cars: [CarDisplay]
  
  
  var body: some View {
    List(cars) { car in
      Button(car.name) {
        router.showScreen(.push) { _ in
          CarDetailView(car: car)
        }
      }
      .swipeActions(edge: .trailing, allowsFullSwipe: false) {
        if vmFav.isFavorite(car) {
          Button {
            vmFav.addFavorite(car)
          } label: {
            Label("Unlike", systemImage: "heart.slash.fill")
          }
          .tint(.gray)
        } else {
          Button {
            vmFav.addFavorite(car)
          } label: {
            Label("Like", systemImage: "heart.fill")
          }
          .tint(.pink)
        }
      }
    }
  }
}

struct CarDetailView: View {
  var car: CarDisplay
  
  var body: some View {
    VStack {
      KingfisherView(url: car.imageURL)
      VStack {
        Text(car.name)
        Text(car.body)
        Text("Size: \(car.height) x \(car.width) x \(car.lenght)")
        Text("MaxSpeed: \(car.topSpeed)")
        Text("Torque: \(car.torque)")
        Text("Wheels size: \(car.wheelBase)")
        Text("Weight: \(car.weight)")
        Text("Price: \(car.price)")
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
