import SwiftUI

// MARK: - Tab Enum
enum Tab: String, CaseIterable {
  case home, catalogue, favorite, profile
  
  var iconName: String {
    switch self {
      case .home: return "house"
      case .catalogue: return "car.side"
      case .favorite: return "heart"
      case .profile: return "person"
    }
  }
  
  var fillIcon: String {
    switch self {
      case .home: return "house.fill"
      case .catalogue: return "car.side.fill"
      case .favorite: return "heart.fill"
      case .profile: return "person.fill"
    }
  }
}

// MARK: - Tab Icon View
struct TabIcon: View {
  let tab: Tab
  let isSelected: Bool
  let onTap: () -> Void
  
  var body: some View {
    Image(systemName: isSelected ? tab.fillIcon : tab.iconName)
      .scaleEffect(isSelected ? 1.25 : 1)
      .foregroundStyle(isSelected ? .blue : .gray)
      .font(.system(size: 22))
      .onTapGesture {
        withAnimation {
          onTap()
        }
      }
  }
}

// MARK: - Custom Tab View
struct CustomTabView: View {
  @Binding var selectedTab: Tab
  
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
      .overlay {
        RoundedRectangle(cornerRadius: 12).stroke(LinearGradient(colors: [.white, .white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing))
      }
      .padding()
    }
  }
}
