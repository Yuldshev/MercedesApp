import SwiftUI

struct HomeView: View {
  @EnvironmentObject var vm: CarViewModel
  
  var filterCar: [CarDisplayCategory] {
    vm.filterCars(by: "Mercedes-AMG SL 43")
  }
  
  var body: some View {
    List {
      ForEach(filterCar) { model in
        ForEach(model.cars) { car in
          Text(car.name)
        }
      }
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
