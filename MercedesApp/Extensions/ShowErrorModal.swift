import SwiftUI
import SwiftfulRouting

extension Router {
  func showErrorModal(message: String, duration: TimeInterval = 3) {
    self.showModal(
      id: message,
      transition: .move(edge: .top),
      animation: .easeInOut,
      alignment: .top,
      backgroundColor: nil,
      dismissOnBackgroundTap: false,
      ignoreSafeArea: false) {
        HStack {
          Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.white)
            .frame(width: 24, height: 24)
          Text(message)
            .font(.system(size: 14))
            .foregroundStyle(.white)
        }
        .padding()
        .background(.red)
        .clipShape(RoundedRectangle(cornerRadius: 8))
      }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      withAnimation {
        self.dismissModal(id: message)
      }
    }
  }
}
