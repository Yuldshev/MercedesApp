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
    .navigationTitle("Authentication")
  }
  
  //MARK: - EmailAuth
  private var EmailAuth: some View {
    VStack(spacing: 16) {
      CustomButton(title: "Sign In", color: .blue) {
        router.showScreen(.push) { _ in
          SignInView()
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

//MARK: -  CustomButton
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

//MARK: - CustomTextField
struct CustomTextField: View {
  var placeholder: String
  @Binding var text: String
  
  var body: some View {
    TextField(placeholder, text: $text)
      .font(.system(size: 16))
      .foregroundStyle(.white)
      .padding()
      .padding(.horizontal, 8)
      .overlay {
        Capsule().stroke()
      }
  }
}

//MARK: - SignInView
struct SignInView: View {
  @State var email = ""
  @State var password = ""
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      CustomTextField(placeholder: "Email", text: $email)
      CustomTextField(placeholder: "Password", text: $password)
      CustomButton(title: "Sign In", color: .pink) {
        
      }
    }
    .padding(.horizontal, 24)
    .modifier(NavigationModifier(title: "Sign In"))
  }
}

//MARK: - RegisterView
struct RegisterView: View {
  @State var name = ""
  @State var email = ""
  @State var password = ""
  @State var confirmPassword = ""
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      CustomTextField(placeholder: "Name", text: $name)
      CustomTextField(placeholder: "Email", text: $email)
      CustomTextField(placeholder: "Password", text: $password)
      CustomTextField(placeholder: "Confirm Password", text: $confirmPassword)
      
      CustomButton(title: "Registration", color: .pink) {
        
      }
    }
    .padding(.horizontal, 24)
    .modifier(NavigationModifier(title: "Create Account"))
  }
}

//MARK: - PoliticsView
struct PoliticsView: View {
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 16) {
        Text("Welcome to our application MercedesApp. These Terms and Conditions govern your use of the App provided by Yuldashev F. By accessing or using the App, you agree to be bound by these Terms. If you do not agree, please do not use the App.")
          .font(.system(size: 12))
        textBlock(header: "1. Use of the App", body: "You must be at least 13 years old to use this App. You agree to use the App only for lawful purposes and in accordance with these Terms.")
        textBlock(header: "2. User Accounts", body: "If the App requires you to create an account, you must provide accurate and complete information. You are responsible for maintaining the confidentiality of your account credentials and for any activity that occurs under your account.")
        textBlock(header: "3. Intellectual Property", body: "All content, features, and functionality of the App are the exclusive property of Yuldashev F. and are protected by copyright, trademark, and other applicable laws.")
        textBlock(header: "4. Privacy", body: "We respect your privacy. Our Privacy Policy explains how we collect, use, and protect your personal information. By using the App, you agree to our Privacy Policy.")
        textBlock(header: "5. Third-Party Services", body: "The App may integrate or interact with third-party services such as Firebase Authentication. We are not responsible for the content, policies, or practices of these third-party services.")
        textBlock(header: "6. Termination", body: "We may suspend or terminate your access to the App at any time, without prior notice or liability, for any reason, including if you breach these Terms.")
        textBlock(header: "7. Disclaimer", body: "The App is provided as is and as available without warranties of any kind. We do not guarantee that the App will be uninterrupted, secure, or error-free.")
        textBlock(header: "8. Limitation of Liability", body: "To the fullest extent permitted by law, we shall not be liable for any indirect, incidental, special, or consequential damages resulting from your use of or inability to use the App.")
        textBlock(header: "9. Changes to Terms", body: "We may update these Terms from time to time. If we make material changes, we will notify you through the App or by other means. Continued use of the App after such changes constitutes your acceptance of the new Terms.")
        textBlock(header: "10. Contact Us", body: "If you have any questions about these Terms, please contact us at ikrom921@gmail.com.")
      }
      .padding(.horizontal, 24)
      .modifier(NavigationModifier(title: "Terms & Conditions"))
    }
  }
  
  private func textBlock(header: String, body: String) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(header)
        .font(.title3)
      Text(body)
        .font(.system(size: 12))
        .fixedSize(horizontal: false, vertical: true)
    }
  }
}

//MARK: - Preview
#Preview {
  NavigationStack {
    AuthView()
  }
}
