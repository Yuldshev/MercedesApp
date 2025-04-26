import SwiftUI

struct HomeView: View {
  @StateObject private var vm = CarViewModel()
  
  init() { vm.clearCache() }
  
  var filteredCars: [CarDisplay] {
    vm.getDisplayCar()
  }
  
  var body: some View {
    VStack {
      List(filteredCars) { car in
        CarRowView(car: car)
      }
    }
    .navigationWithLarge(title: "Home")
    .task {
      await vm.fetchAllClass(limit: 1)
    }
  }
}

struct CarRowView: View {
  let car: CarDisplay
  
  var body: some View {
    HStack(alignment: .top, spacing: 16) {
      AsyncImage(url: car.imageURL) { image in
        image.resizable()
      } placeholder: {
        Color.gray.opacity(0.2)
      }
      .frame(width: 100, height: 60)
      .cornerRadius(8)
      
      VStack(alignment: .leading, spacing: 4) {
        Text(car.name)
          .font(.headline)
        Text(car.price.formatted())
          .foregroundColor(.secondary)
        HStack {
          Text("💪 \(car.powerHp)")
          Text("🚀 \(car.topSpeed)")
        }
        .font(.subheadline)
        .foregroundColor(.gray)
      }
    }
    .padding(.vertical, 8)
  }
}


#Preview {
  HomeView()
    .previewWithRouter()
}
