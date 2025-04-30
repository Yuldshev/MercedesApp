import SwiftUI

struct CarListTypeView: View {
  @EnvironmentObject var vm: FavoriteViewModel
  @Environment(\.router) var router
  var header: String
  var cars: [(CarDisplay)]
  
  var body: some View {
    VStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(header)
          .font(.corporateAMedium(size: 34))
        Divider()
      }
      .padding(.horizontal, 24)
      .frame(maxWidth: .infinity, alignment: .leading)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(cars) { car in
            Button {
              router.showScreen(.push) { _ in
                CarDetailView(car: car)
                  .environmentObject(vm)
              }
            } label: {
              CarModelCartView(car: car)
            }
              .frame(width: 200, height: 220)
              .environmentObject(vm)
              .containerRelativeFrame(.horizontal, count: 2, spacing: 16)
              .scrollTransition { content, phase in
                content.opacity(phase.isIdentity ? 1 : 0.5)
              }
          }
        }
        .scrollTargetLayout()
      }
      .frame(height: 220)
      .contentMargins(16, for: .scrollContent)
      .scrollTargetBehavior(.viewAligned)
    }
  }
}

#Preview {
  CarListTypeView( header: "For Family", cars: [CarDisplay(name: "E 200 d Estate", body: "", price: "", topSpeed: "", powerHp: "", torque: "", lenght: "", width: "", height: "", wheelBase: "", weight: "", imageURL: URL(string: "https://media.oneweb.mercedes-benz.com/images/dynamic/europe/DE/214203/806/iris.png?q=COSY-EU-100-1713d0VXqaWeqtyO67PobzIr3eWsrrCsdRRzwQZQ9vZbMw3SGtxmFtsd2HdcUfpAfXGEjamJ0lVHxOB2sW2bApvAVI5uLe2QC3bsOkzN4P9m7jgcmhKVPX9%25vqeIkyLR5cHYaxCoWrH1zjRn8w7hnoiZKMIM4FvsJTg97hN6PD47mSeWq1%25tsdUvGcUfGLyXGE0iEJ08xLdSQjuROxAcUiRElYO2EW5WtVt4jU0i3gjaZHpQ6LGy&imgt=P27&bkgnd=9&pov=BE040")), CarDisplay(name: "GLE 300 d", body: "", price: "", topSpeed: "", powerHp: "", torque: "", lenght: "", width: "", height: "", wheelBase: "", weight: "", imageURL: URL(string: "https://media.oneweb.mercedes-benz.com/images/dynamic/europe/DE/167309/806/iris.png?q=COSY-EU-100-1713d0VXqahFqtyO67PobzIr3eWsrrCsdRRzwQZgk4ZbMw3SGtlaWtsd2HVcUfpO6XGEubXJ0l3otOB2NS1bApRiyI5uG5IQC30kTkzNHTwm7j86ohKViKh%25vq4ylyLRgYFYax%250qrH1yM%25n8w0AEoiZB%25YM4FvIPTg9Lg26PDacpSeWHnStsd8oGcUfiXyXGE45jJ0lgCZOB2fr%25bApPkCI5ug41QC3ACWkzN5Unm7jC2jhKVfLY%25vqLtTyLRacVYaxHahrH18B%25n8wiAxoiCpBxySfD2MpC75v2pZbMFwRPRYEY7fHizWKfAN59S%25B8O&imgt=P27&bkgnd=9&pov=BE040")), CarDisplay(name: "GLE 300 d", body: "", price: "", topSpeed: "", powerHp: "", torque: "", lenght: "", width: "", height: "", wheelBase: "", weight: "", imageURL: URL(string: "https://media.oneweb.mercedes-benz.com/images/dynamic/europe/DE/247610/806/iris.png?q=COSY-EU-100-1713d0VXqNEeqtyO67PobzIr3eWsrrCsdRRzwQZxkIZbMw3SGtle9tsd2HVcUfpOcXGEunSJ0l3ofOB2qBqbApRiyI5ux6YQC30M1kzNBtum7j86ZhKViSV%25vq4vZyLRhGVYax%25ohrH1GBln8w0zEoiZB%25YM4FAOFTg9LQe6PDacpSeWHnStsd8oxcUfiXyXGE45jJ0lgCZOB2fQcbApETRI5uefJQC3PwOBo38ZbA4epFI5QM19QCkTmDkzm65Wm7hRVdhK%25A9f%25XsSz9p4HeEsYGczVIvqELKCrCDgDO4m%25J8b4t0capFShV&imgt=P27&bkgnd=9&pov=BE040"))])
    .environmentObject(FavoriteViewModel())
}
