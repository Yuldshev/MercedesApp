import SwiftUI
import Pow

struct LoginView: View {
  @EnvironmentObject var vm: LoginViewModel
  @FocusState var focused: Field?
  @Environment(\.router) var router
  
  var body: some View {
    ZStack {
      Color.appLightGray.ignoresSafeArea()
      
      VStack(spacing: 16) {
        CustomTextField(placeholder: "Email", text: $vm.email, isSecure: false)
          .focused($focused, equals: .email)
          .onSubmit { focused = .password }
          .submitLabel(.next)
          .keyboardType(.emailAddress)
          .textContentType(.emailAddress)
        
        CustomTextField(placeholder: "Password", text: $vm.password, isSecure: true)
          .focused($focused, equals: .password)
          .onSubmit { focused = nil }
          .submitLabel(.continue)
          .textContentType(.password)
        
        CustomButton(title: "Sign In", image: nil) {
          Task {
            await vm.login()
          }
        }
        .changeEffect(.shine.delay(0.5), value: vm.isLoading)
      }
      .padding(.horizontal, 24)
      .navigationWithInline(title: "Sign In")
      .onAppear { focused = .email}
      .onChange(of: vm.message) { _, new in
        switch new {
          case .error(let text):
            router.showErrorModal(message: text)
          case .success(let text):
            router.showSuccessModal(message: text)
        }
      }
    }
  }
}

#Preview {
  LoginView()
    .environmentObject(LoginViewModel())
    .previewWithRouter()
}
