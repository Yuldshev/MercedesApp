#if DEBUG
import SwiftUI
import SwiftfulRouting

extension View {
  func previewWithRouter() -> some View {
    RouterView { _ in
      self
    }
  }
}

#endif

