import SwiftUI

struct BannerHomeView: View {
  @EnvironmentObject var vm: CarViewModel
  @EnvironmentObject var favVm: FavoriteViewModel
  @Environment(\.router) var router
  
  @State private var currentIndex = 0
  private let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
  
  private var banners: [(CarDisplay, BannerCars)] {[
    (vm.filterCars(by: "S 350 d Sedan").first, .e350),
    (vm.filterCars(by: "G 450 d").first, .g450d),
    (vm.filterCars(by: "GLS 450").first, .gls450)
  ].compactMap { car, image in
    guard let car = car else { return nil}
    return (car, image)
  }}
  
  var body: some View {
    TabView(selection: $currentIndex) {
      ForEach(Array(banners.enumerated()), id: \.offset) { index, banner in
        let (car, image) = banner
        Button {
          router.showScreen(.push) { _ in
            CarDetailView(car: car).environmentObject(favVm)
          }
        } label: {
          bannerScreen(image: image)
            .tag(index)
        }
      }
    }
    .frame(height: 240)
    .tabViewStyle(.page(indexDisplayMode: .automatic))
    .padding(.bottom, -8)
    .onReceive(timer) { _ in
      withAnimation {
        currentIndex = (currentIndex + 1) % banners.count
      }
    }
    .task {
      await vm.fetchAllClass()
    }
  }
  
  private func bannerScreen(image: BannerCars) -> some View {
    VStack(alignment: .leading, spacing: 0) {
      Image(image.rawValue)
        .resizable()
        .scaledToFill()
        .clipped()
    }
  }
}

enum BannerCars: String {
  case e350, g450d, gls450
}

#Preview {
  BannerHomeView()
    .environmentObject(CarViewModel())
    .environmentObject(FavoriteViewModel())
    .previewWithRouter()
}
