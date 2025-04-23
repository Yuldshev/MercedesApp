import SwiftUI

struct CustomTextField: View {
  var placeholder: String
  @Binding var text: String
  
  var body: some View {
    TextField(placeholder, text: $text)
      .autocorrectionDisabled()
      .font(.system(size: 16))
      .padding()
      .padding(.horizontal, 8)
      .overlay {
        Capsule().stroke()
      }
  }
}

#Preview {
  CustomTextField(placeholder: "Text", text: .constant(""))
}
