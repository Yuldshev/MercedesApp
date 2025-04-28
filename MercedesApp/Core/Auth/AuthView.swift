import SwiftUI
import Pow

struct AuthView: View {
  @StateObject private var vm = LoginViewModel()
  @Environment(\.router) var router
  @State private var isLoading = false
  
  var body: some View {
    ZStack {
      Color.appLightGray.ignoresSafeArea()
      
      VStack(spacing: 16) {
        EmailAuth
        BottomText
      }
      .padding(.horizontal, 24)
    }
  }
  
  //MARK: - EmailAuth
  private var EmailAuth: some View {
    VStack(spacing: 16) {
      CustomButton(title: "Sign In", image: nil) {
        router.showScreen(.push,) { _ in
          LoginView().environmentObject(vm)
        }
      }
      
      CustomButton(title: "Create Account", image: nil, color: .blue) {
        router.showScreen(.push) { _ in
          RegisterView()
        }
      }
      .conditionalEffect(.repeat(.glow(color: .blue, radius: 30), every: 1.5), condition: !isLoading)
    }
  }
  
  //MARK: - BottomText
  private var BottomText: some View {
    VStack(spacing: 4) {
      Text("By creating an account or signing you agree to our")
      Button {
        router.showResizableSheet(sheetDetents: [.medium, .large], selection: nil, showDragIndicator: true) { _ in
          PoliticsView()
        }
      } label: {
        Text("Terms and Conditions")
          .foregroundStyle(.blue)
          .font(.arialBold(size: 12))
          .underline()
      }
    }
    .font(.arialRegular(size: 12))
  }
}

//MARK: - FocusField
enum Field {
  case name, email, password, confirmPassword
}

//MARK: - Preview
#Preview {
  NavigationStack {
    AuthView()
      .previewWithRouter()
  }
}
