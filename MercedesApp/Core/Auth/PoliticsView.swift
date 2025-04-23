import SwiftUI

struct PoliticsView: View {
  private let data = [
    ("", "Welcome to our application MercedesApp. These Terms and Conditions govern your use of the App provided by Yuldashev F. By accessing or using the App, you agree to be bound by these Terms. If you do not agree, please do not use the App."),
    ("1. Use of the App", "You must be at least 13 years old to use this App. You agree to use the App only for lawful purposes and in accordance with these Terms."),
    ("2. User Accounts", "If the App requires you to create an account, you must provide accurate and complete information. You are responsible for maintaining the confidentiality of your account credentials and for any activity that occurs under your account."),
    ("3. Intellectual Property", "All content, features, and functionality of the App are the exclusive property of Yuldashev F. and are protected by copyright, trademark, and other applicable laws."),
    ("4. Privacy", "We respect your privacy. Our Privacy Policy explains how we collect, use, and protect your personal information. By using the App, you agree to our Privacy Policy."),
    ("5. Third-Party Services", "The App may integrate or interact with third-party services such as Firebase Authentication. We are not responsible for the content, policies, or practices of these third-party services."),
    ("6. Termination", "We may suspend or terminate your access to the App at any time, without prior notice or liability, for any reason, including if you breach these Terms."),
    ("7. Disclaimer", "The App is provided as is and as available without warranties of any kind. We do not guarantee that the App will be uninterrupted, secure, or error-free."),
    ("8. Limitation of Liability", "To the fullest extent permitted by law, we shall not be liable for any indirect, incidental, special, or consequential damages resulting from your use of or inability to use the App."),
    ("9. Changes to Terms", "We may update these Terms from time to time. If we make material changes, we will notify you through the App or by other means. Continued use of the App after such changes constitutes your acceptance of the new Terms."),
    ("10. Contact Us", "If you have any questions about these Terms, please contact us at ikrom921@gmail.com.")
  ]
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 16) {
        ForEach(data.indices, id: \.self) { index in
          textBlock(header: data[index].0, body: data[index].1)
        }
      }
      .padding(.horizontal, 24)
      .modifier(NavigationModifier(title: "Terms & Conditions"))
    }
  }
  
  private func textBlock(header: String, body: String) -> some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(header)
        .font(.system(size: 18, weight: .semibold))
      Text(body)
        .font(.system(size: 12))
        .fixedSize(horizontal: false, vertical: true)
    }
  }
}
#Preview {
  PoliticsView()
}
