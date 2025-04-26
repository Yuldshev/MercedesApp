import SwiftUI
import Kingfisher

struct KingfisherView: View {
  var url: URL?
  
  var body: some View {
    Group {
      if let url = url {
        KFImage(url)
          .placeholder { ProgressView() }
          .resizable()
          .scaledToFit()
      } else {
        Color.gray.opacity(0.2)
      }
    }
  }
}
