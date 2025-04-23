import SwiftUI

struct InlineNavigation: ViewModifier {
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

struct HeaderNavigation: ViewModifier {
  @Environment(\.dismiss) var dismiss
  let title: String
  
  func body(content: Content) -> some View {
    content
      .navigationTitle(title)
      .navigationBarTitleDisplayMode(.large)
      .navigationBarBackButtonHidden()
  }
}

extension View {
  func navigationWithInline(title: String) -> some View {
    self.modifier(InlineNavigation(title: title))
  }
  
  func navigationWithLarge(title: String) -> some View {
    self.modifier(HeaderNavigation(title: title))
  }
}
