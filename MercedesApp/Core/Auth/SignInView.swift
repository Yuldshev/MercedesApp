import SwiftUI

struct SignInView: View {
  @StateObject private var vm = LoginViewModel()
  @FocusState var focused: Field?
  @Environment(\.router) var router
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      CustomTextField(placeholder: "Email", text: $vm.email)
        .focused($focused, equals: .email)
        .onSubmit { focused = .password }
        .submitLabel(.next)
        .keyboardType(.emailAddress)
        .textContentType(.emailAddress)
      
      CustomTextField(placeholder: "Password", text: $vm.password)
        .focused($focused, equals: .password)
        .onSubmit { focused = nil }
        .submitLabel(.continue)
        .textContentType(.password)
      
      CustomButton(title: "Sign In", color: .pink) {
        Task {
          await vm.login()
        }
      }
    }
    .padding(.horizontal, 24)
    .navigationWithInline(title: "Sign In")
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        focused = .email
      }
    }
    .onChange(of: vm.errorMessage) { oldValue, newValue in
      if !newValue.isEmpty {
        router.showErrorModal(message: vm.errorMessage)
        vm.errorMessage = ""
      }
    }
  }
}

#Preview {
  SignInView()
}
