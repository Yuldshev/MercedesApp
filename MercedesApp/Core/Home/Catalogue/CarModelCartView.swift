import SwiftUI

struct CarModelCartView: View {
  @EnvironmentObject var vm: FavoriteViewModel
  var car: CarDisplay
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text("\(car.name)")
        .font(.corporateAMedium(size: 18))
        .frame(maxWidth: 100, alignment: .leading)
        .lineLimit(2)
      Text("Starting at \(car.price)")
        .font(.arialRegular(size: 12))
        .foregroundStyle(.appDarkGray.opacity(0.6))
      
      Spacer()
      
      KingfisherView(url: car.imageURL)
        .offset(x: -10)
        .scaleEffect(1.4)
        .frame(maxWidth: 150, maxHeight: 100)
        .clipped()
      
      Spacer()
      
      Divider()
      
      HStack {
        Text("Details")
          .font(.arialRegular(size: 12))
        Spacer()
        Image(systemName: "chevron.right")
          .font(.system(size: 12))
      }
      .padding(.top, 4)
    }
    .padding()
    .overlay(alignment: .topTrailing) {
      favoriteButton
    }
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
        .foregroundStyle(vm.isFavorite(car) ? .red : .appDarkGray.opacity(0.6))
        .frame(width: 24, height: 24)
        .padding()
        .contentShape(Rectangle())
    }
    .changeEffect(.spray(origin: UnitPoint(x: 0.25, y: 0.5), {
      Image(systemName: "heart.fill").foregroundStyle(.red)
    }), value: vm.isFavorite(car))
  }
}
