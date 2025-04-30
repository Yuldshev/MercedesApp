import SwiftUI

struct CustomButtonList: View {
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      VStack {
        HStack {
          Text(title)
            .font(.corporateARegular(size: 18))
          Spacer()
          Image(systemName: "chevron.right")
        }
        Divider()
      }
    }
  }
}
