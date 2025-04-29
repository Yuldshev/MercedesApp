import SwiftUI

struct CatalogClassView: View {
  var className: CarDisplayCategory
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(className.className == "Mercedes-AMG GT" ?  "Mercedes-AMG GT" : "Mercedes \(className.className)")
        .font(.corporateAMedium(size: 18))
        .lineLimit(2)
        .multilineTextAlignment(.leading)
        .fixedSize(horizontal: false, vertical: true)
      
      if let image = className.cars.first?.imageURL {
        KingfisherView(url: image)
          .frame(maxWidth: 150, maxHeight: 100)
          .scaleEffect(1.2)
          .offset(x: -10)
          .clipped()
      }
      Spacer()
      Divider()
      HStack {
        Text("Cars count:")
        Spacer()
        Text(className.cars.count.description)
      }
      .font(.arialRegular(size: 12))
      
    }
    .padding()
  }
}
