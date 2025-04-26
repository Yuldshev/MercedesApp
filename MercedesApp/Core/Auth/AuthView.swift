import SwiftUI

struct AuthView: View {
  @Environment(\.router) var router
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      EmailAuth
      AuthDivider
      TokenAuth
      BottomText
    }
    .padding(.horizontal, 24)
    .navigationWithLarge(title: "Authentication")
  }
  
  //MARK: - EmailAuth
  private var EmailAuth: some View {
    VStack(spacing: 16) {
      CustomButton(title: "Sign In", color: .blue) {
        router.showScreen(.push) { _ in
          LoginView()
        }
      }
      
      CustomButton(title: "Create Account", color: .gray) {
        router.showScreen(.push) { _ in
          RegisterView()
        }
      }
    }
  }
  
  //MARK: - AuthDivider
  private var AuthDivider: some View {
    HStack {
      VStack { Divider() }
      Text("Login with")
      VStack { Divider() }
    }
    .padding(.vertical, 8)
  }
  
  //MARK: - TokenAuth
  private var TokenAuth: some View {
    VStack(spacing: 16) {
      CustomButton(title: "Sign in with Google", color: .pink) {
        
      }
      
      CustomButton(title: "Sign in with Apple", color: .black) {
        
      }
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
          .bold()
          .underline()
      }
    }
    .font(.system(size: 12))
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
