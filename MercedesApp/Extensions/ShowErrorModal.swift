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
            .font(.arialRegular(size: 14))
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
  
  func showSuccessModal(message: String, duration: TimeInterval = 3) {
    self.showModal(
      id: message,
      transition: .move(edge: .top),
      animation: .easeInOut,
      alignment: .top,
      backgroundColor: nil,
      dismissOnBackgroundTap: false,
      ignoreSafeArea: false) {
        HStack {
          Image(systemName: "checkmark.seal.fill")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.white)
            .frame(width: 24, height: 24)
          Text(message)
            .font(.arialRegular(size: 14))
            .foregroundStyle(.white)
        }
        .padding()
        .background(.green)
        .clipShape(RoundedRectangle(cornerRadius: 8))
      }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
      withAnimation {
        self.dismissModal(id: message)
      }
    }
  }
}

enum AppMessage: Equatable {
  case error(String)
  case success(String)
  
  static func == (lhs: AppMessage, rhs: AppMessage) -> Bool {
    switch (lhs, rhs) {
      case (.error(let lhsMsg), .error(let rhsMsg)):
        return lhsMsg == rhsMsg
      case (.success(let lhsMsg), .success(let rhsMsg)):
        return lhsMsg == rhsMsg
      default:
        return false
    }
  }
}
