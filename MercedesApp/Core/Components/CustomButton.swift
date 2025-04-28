import SwiftUI

struct CustomButton: View {
  let title: String
  let image: Image?
  var color: Color = .black
  let action: () -> Void
  
  
  var body: some View {
    Button(action: action) {
      HStack {
        if let image {
          image
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
        }
        Text(title)
          .font(.arialRegular(size: 16))
      }
      .foregroundStyle(.white)
      .frame(maxWidth: .infinity)
      .frame(height: 52)
      .background(color)
      .clipShape(RoundedRectangle(cornerRadius: 12))
    }
  }
}
