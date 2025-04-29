import SwiftUI

struct InlineNavigation: ViewModifier {
  @Environment(\.dismiss) var dismiss
  @State private var drag = CGSize.zero
  let title: String
  
  func body(content: Content) -> some View {
    content
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button { dismiss() } label: {
            Image(systemName: "chevron.left")
              .foregroundStyle(.black)
              .padding(20)
              .contentShape(Rectangle())
          }
        }
        
        ToolbarItem(placement: .principal) {
          Text(title)
            .font(.corporateAMedium(size: 24))
        }
      }
    
  }
}

struct HeaderNavigation: ViewModifier {
  @Environment(\.dismiss) var dismiss
  let title: String
  
  func body(content: Content) -> some View {
    content
      .navigationBarTitleDisplayMode(.large)
      .navigationBarBackButtonHidden()
      .toolbar {
        ToolbarItem(placement: .navigation) {
          Text(title)
            .font(.corporateAMedium(size: 36))
            
        }
      }
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
