import SwiftUI

struct RegisterView: View {
  @StateObject private var vm = RegisterViewModel()
  @FocusState var focused: Field?
  @Environment(\.router) var router
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      VStack(spacing: 16) {
        CustomTextField(placeholder: "Name", text: $vm.name)
          .focused($focused, equals: .name)
          .onSubmit { focused = .email}
        CustomTextField(placeholder: "Email", text: $vm.email)
          .focused($focused, equals: .email)
          .onSubmit { focused = .password}
        CustomTextField(placeholder: "Password", text: $vm.password)
          .focused($focused, equals: .password)
          .onSubmit { focused = .confirmPassword}
        CustomTextField(placeholder: "Confirm Password", text: $vm.confirmPassword)
          .focused($focused, equals: .confirmPassword)
          .onSubmit { focused = nil}
      }
      .submitLabel(.next)
      
      CustomButton(title: "Registration", color: .pink) {
        Task {
          await vm.register()
        }
      }
    }
    .padding(.horizontal, 24)
    .modifier(NavigationModifier(title: "Create Account"))
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
  RegisterView()
}
