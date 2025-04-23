import SwiftUI

struct ProfileView: View {
  @StateObject private var vm = ProfileViewModel()
  @Environment(\.router) var router
  
  var body: some View {
    VStack {
      CustomButton(title: "Log out", color: .pink) {
        Task {
          await vm.signOut()
        }
      }
    }
    .padding(.horizontal, 24)
    .onChange(of: vm.errorMessage) { oldValue, newValue in
      if !newValue.isEmpty {
        router.showErrorModal(message: vm.errorMessage)
        vm.errorMessage = ""
      }
    }
  }
}

#Preview {
  ProfileView()
}
