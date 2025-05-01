import SwiftUI

struct HomeView: View {
  @EnvironmentObject var vm: CarViewModel
  @EnvironmentObject var vmLike: FavoriteViewModel
  @Environment(\.router) var router
  
  var body: some View {
    ZStack {
      Color.appLightGray.ignoresSafeArea()
      
      ScrollView(.vertical, showsIndicators: false) {
        VStack(spacing: 16) {
          BannerHomeView()
            .environmentObject(vmLike)
          
          familyCars
            .padding(.top, 16)
          
          offroad
            .padding(.top, 16)
          
          business
            .padding(.top, 16)
        }
        .navigationWithLarge(title: "Home")
        .onChange(of: vm.message, { _, new in
          switch new {
            case .error(let text):
              router.showErrorModal(message: text)
            case .success(let text):
              router.showSuccessModal(message: text)
          }
        })
        .task {
          await vm.fetchAllClass()
        }
      }
    }
  }
  
  private var familyCars: some View {
    VStack {
      let cars = [
        vm.filterCars(by: "E 200 d Estate").first,
        vm.filterCars(by: "GLE 300 d 4MATIC").first,
        vm.filterCars(by: "GLB 180 d").first,
        vm.filterCars(by: "A 220 d").first
      ].compactMap { $0 }
      CarListTypeView(header: "For Family", cars: cars).environmentObject(vmLike)
    }
  }
  
  private var offroad: some View {
    VStack {
      let cars = [
        vm.filterCars(by: "Mercedes-AMG G 63").first,
        vm.filterCars(by: "GLS 580 4MATIC").first,
        vm.filterCars(by: "Mercedes-AMG GLE 53").first,
        vm.filterCars(by: "GLB 200").first
      ].compactMap { $0 }
      CarListTypeView(header: "Offroad", cars: cars).environmentObject(vmLike)
    }
  }
  
  private var business: some View {
    VStack {
      let cars = [
        vm.filterCars(by: "S 350 d Sedan").first,
        vm.filterCars(by: "Mercedes-Maybach S 580").first,
        vm.filterCars(by: "Mercedes-Maybach S 680").first
      ].compactMap { $0 }
      CarListTypeView(header: "Business", cars: cars).environmentObject(vmLike)
    }
  }
}

#Preview {
  HomeView()
    .environmentObject(CarViewModel())
    .environmentObject(FavoriteViewModel())
    .previewWithRouter()
}
