import SwiftUI

struct SplashView: View {
  @State private var scaleAmount: CGFloat = 1
  
    var body: some View {
      ZStack {
        Color.black.ignoresSafeArea()
        VStack {
          Image("mercedes")
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .scaleEffect(scaleAmount)
            .foregroundStyle(.white)
        }
      }
      .onAppear {
        //MARK: - Shrink
        withAnimation(.easeOut(duration: 1)) {
          scaleAmount = 0.6
        }
        
        //MARK: - Enlarge
        withAnimation(.easeInOut(duration: 1).delay(1)) {
          scaleAmount = 80
        }
      }
    }
}

#Preview {
    SplashView()
}
