import SwiftUI
import FirebaseCore

@main
struct MercedesApp: App {
  init() { FirebaseApp.configure() }
  
  var body: some Scene {
    WindowGroup {
      MainView()
        .preferredColorScheme(.light)
    }
  }
}
