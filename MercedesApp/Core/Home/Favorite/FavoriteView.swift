import SwiftUI

struct FavoriteView: View {
  @EnvironmentObject var vmFav: FavoriteViewModel
  
  var body: some View {
    VStack {
      List(vmFav.favorites) { item in
        Text(item.name)
      }
    }
    .navigationWithLarge(title: "Favorite List")
  }
}

#Preview {
  FavoriteView()
    .environmentObject(FavoriteViewModel())
    .previewWithRouter()
}
