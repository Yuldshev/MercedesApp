import SwiftUI
import Pow

struct RegisterView: View {
  @StateObject private var vm = RegisterViewModel()
  @FocusState var focused: Field?
  @Environment(\.router) var router
  
  var body: some View {
    ZStack {
      Color.appLightGray.ignoresSafeArea()
      
      VStack(spacing: 16) {
        CustomTextField(placeholder: "Name", text: $vm.name, isSecure: false)
          .focused($focused, equals: .name)
          .onSubmit { focused = .email}
        CustomTextField(placeholder: "Email", text: $vm.email, isSecure: false)
          .focused($focused, equals: .email)
          .onSubmit { focused = .password}
        CustomTextField(placeholder: "Password", text: $vm.password, isSecure: true)
          .focused($focused, equals: .password)
          .onSubmit { focused = .confirmPassword}
        CustomTextField(placeholder: "Confirm Password", text: $vm.confirmPassword, isSecure: true)
          .focused($focused, equals: .confirmPassword)
          .onSubmit { focused = nil}
        
        CustomButton(title: "Registration", image: nil) {
          Task {
            await vm.register()
          }
        }
        .changeEffect(.shine.delay(0.5), value: vm.isLoading)
      }
      .submitLabel(.next)
      .padding(.horizontal, 24)
      .navigationWithInline(title: "Create Account")
      .onAppear { focused = .name }
      .onChange(of: vm.message) { _, new in
        switch new {
          case .error(let text):
            router.showErrorModal(message: text)
            vm.message = .error("")
          case .success(let text):
            router.showSuccessModal(message: text)
        }
      }
    }
  }
}

#Preview {
  RegisterView()
    .previewWithRouter()
}
