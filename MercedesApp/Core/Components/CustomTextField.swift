import SwiftUI

struct CustomTextField: View {
  var placeholder: String
  @Binding var text: String
  var isSecure: Bool
  @State private var isShow = false
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 4) {
        Text(placeholder)
          .font(.arialRegular(size: 12))
          .foregroundStyle(.appDarkGray)
        
        if isSecure {
          if isShow {
            TextField("", text: $text)
              .font(.arialRegular(size: 16))
              .autocorrectionDisabled()
              .textContentType(.password)
              .textInputAutocapitalization(.never)
          } else {
            SecureField("", text: $text)
              .font(.arialRegular(size: 16))
              .autocorrectionDisabled()
              .textInputAutocapitalization(.never)
              .textContentType(.password)
          }
        } else {
          TextField("", text: $text)
            .font(.arialRegular(size: 16))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .textContentType(placeholder == "Email" ? .emailAddress : .name)
            .keyboardType(placeholder == "Email" ? .emailAddress : .default)
        }
      }
      if isSecure {
        Button(action: { isShow.toggle() }) {
          Image(systemName: isShow ? "eye.slash.fill" : "eye.fill")
            .foregroundStyle(.appDarkGray)
            .frame(width: 19, height: 16)
        }
      }
    }
    .padding(.horizontal)
    .frame(maxWidth: .infinity)
    .frame(height: 60)
    .background(.white)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}
