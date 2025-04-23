import SwiftUI

struct CustomButton: View {
  var title: String
  var color: Color
  var action: () -> Void
  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.system(size: 16))
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .background(color)
        .clipShape(Capsule())
    }
  }
}

#Preview {
  CustomButton(title: "Button", color: .pink, action: {})
}
