import SwiftUI

struct NavigationModifier: ViewModifier {
  @Environment(\.dismiss) var dismiss
  let title: String
  
  func body(content: Content) -> some View {
    content
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button { dismiss() } label: {
            Image(systemName: "chevron.left")
              .foregroundStyle(.black)
          }
        }
      }
  }
}
