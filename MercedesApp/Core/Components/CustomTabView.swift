import SwiftUI

// MARK: - Tab Enum
enum Tab: String, CaseIterable {
  case home, catalogue, favorite, profile
  
  var iconName: String {
    switch self {
      case .home: return "icon.home"
      case .catalogue: return "icon.class"
      case .favorite: return "icon.like"
      case .profile: return "icon.profile"
    }
  }
}

// MARK: - Tab Icon View
struct TabIcon: View {
  let tab: Tab
  let isSelected: Bool
  let onTap: () -> Void
  
  var fillIcon: String {
    tab.iconName + ".fill"
  }
  
  var body: some View {
    Image(isSelected ? fillIcon : tab.iconName)
      .resizable()
      .scaledToFit()
      .frame(width: 24, height: 24)
      .scaleEffect(isSelected ? 1.25 : 1)
      .offset(y: isSelected ? -3 : 0)
      .foregroundStyle(isSelected ? .blue : .gray)
      .padding(20)
      .contentShape(Rectangle())
      .onTapGesture {
        withAnimation(.spring()) {
          onTap()
        }
      }
  }
}

// MARK: - Custom Tab View
struct CustomTabView: View {
  @Environment(\.colorScheme) var threme
  @Binding var selectedTab: Tab
  
  var gradienColor: [Color] {
    threme == .light ? [.gray.opacity(0.6), .white.opacity(0)] : [.white.opacity(0.6), .white.opacity(0)]
  }
  
  var body: some View {
    VStack {
      HStack {
        ForEach(Tab.allCases, id: \.rawValue) { tab in
          Spacer()
          
          TabIcon(tab: tab, isSelected: selectedTab == tab) {
            selectedTab = tab
          }
          
          Spacer()
        }
      }
      .frame(height: 60)
      .background(.thinMaterial)
      .clipShape(RoundedRectangle(cornerRadius: 12))
      .animation(.spring(), value: selectedTab)
      .overlay {
        RoundedRectangle(cornerRadius: 12).stroke(LinearGradient(colors: gradienColor, startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 0.5)
      }
      .padding()
    }
  }
}

#Preview {
  CustomTabView(selectedTab: .constant(.home))
}
