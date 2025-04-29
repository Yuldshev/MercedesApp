import SwiftUI

struct CarDetailView: View {
  @EnvironmentObject var vm: FavoriteViewModel
  @Environment(\.router) var router
  var car: CarDisplay
  
  let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  var body: some View {
    ZStack {
      Color.appLightGray.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 8) {
        image
        header
        specification
        Spacer()
        price
      }
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
  
  private var image: some View {
    KingfisherView(url: car.imageURL)
      .frame(maxWidth: .infinity)
      .frame(height: 120)
  }
  
  private var header: some View {
    VStack(alignment: .leading, spacing: 4.0) {
      Text(car.name)
        .font(.corporateAMedium(size: 24))
      Text(car.body)
        .font(.arialRegular(size: 14))
        .foregroundStyle(.appDarkGray.opacity(0.6))
    }
    .padding(.horizontal, 24)
    .padding(.top, 32)
  }
  
  private var specification: some View {
    VStack(alignment: .leading) {
      Text("Specification")
        .font(.corporateAMedium(size: 24))
      Divider()
      LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
        CarDetailInfo(header: "Top Speed", info: car.topSpeed)
        CarDetailInfo(header: "Power HP", info: car.powerHp)
        CarDetailInfo(header: "Torque", info: car.torque)
        CarDetailInfo(header: "Max weight", info: car.weight)
        CarDetailInfo(header: "Car size", info: "\(car.width) x \(car.height) x \(car.lenght)")
        CarDetailInfo(header: "Wheel base", info: car.wheelBase)
      }
      .padding(.top, 4)
    }
    .padding(.horizontal, 24)
    .padding(.top, 16)
  }
  
  private var price: some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Text("Starting at price")
          .font(.arialBold(size: 12))
        Text(car.price)
          .font(.arialBold(size: 22))
      }
      .foregroundStyle(.white)
      Spacer()
      favoriteButton
    }
    .padding(.horizontal, 24)
    .padding(.vertical, 8)
    .frame(maxWidth: .infinity, alignment: .leading)
    .frame(height: 50)
    .background(.black)
  }
  
  private var favoriteButton: some View {
    Button {
      withAnimation {
        if vm.isFavorite(car) {
          vm.removeFavorite(car)
        } else {
          vm.addFavorite(car)
        }
      }
    } label: {
      Image(systemName: vm.isFavorite(car) ? "heart.fill" : "heart")
        .resizable()
        .scaledToFit()
        .foregroundStyle(vm.isFavorite(car) ? .red : .white)
        .frame(width: 24, height: 24)
        .padding()
        .contentShape(Rectangle())
    }
    .changeEffect(.spray(origin: UnitPoint(x: 0.25, y: 0.5), {
      Image(systemName: "heart.fill").foregroundStyle(.red)
    }), value: vm.isFavorite(car))
  }
}

struct CarDetailInfo: View {
  var header: String
  var info: String
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(header)
        .font(.arialBold(size: 16))
      Text(info)
        .font(.arialRegular(size: 12))
        .foregroundStyle(.appDarkGray.opacity(0.6))
    }
  }
}

