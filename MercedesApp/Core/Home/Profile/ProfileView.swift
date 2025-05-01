import SwiftUI
import _PhotosUI_SwiftUI

struct ProfileView: View {
  @StateObject private var vm = ProfileViewModel()
  @State private var selectedItem: PhotosPickerItem?
  @Environment(\.router) var router
  
  var body: some View {
    ZStack {
      Color.appLightGray.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 16) {
        header
        Spacer()
        termsAndConditions
        versusView
        localization
        logOut
        author
        Spacer()
      }
      .padding(.horizontal, 24)
      .navigationWithLarge(title: "Profile")
      .task { await vm.fetchUser() }
      .onChange(of: vm.message) { _, new in
        switch new {
          case .error(let text):
            router.showErrorModal(message: text)
          case .success(let text):
            router.showSuccessModal(message: text)
        }
      }
    }
  }
  
  private var header: some View {
    HStack(spacing: 16) {
      let user = vm.user
      PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
        Group {
          if let image = user?.profileImageURL {
            KingfisherView(url: URL(string: image))
          } else {
            Image(.mercedes)
              .resizable()
              .scaledToFit()
              .padding()
              .foregroundStyle(.white)
          }
        }
        .frame(width: 64, height: 64)
        .background(.black)
        .clipShape(Circle())
      }
      .onChange(of: selectedItem) { _, new in
        Task {
          await vm.uploadAvatar(from: new)
        }
      }
      
      Text("\(vm.user?.name ?? "Unknown") member of 'Mercedes Club' since \(vm.user?.joined.formatterDate() ?? "")")
        .font(.arialRegular(size: 16))
    }
  }
  
  private var termsAndConditions: some View {
    CustomButtonList(title: "Terms & Conditions") {
      router.showResizableSheet(sheetDetents: [.medium, .large], selection: nil, showDragIndicator: true) { _ in
        PoliticsView()
      }
    }
  }
  
  private var versusView: some View {
    CustomButtonList(title: "Versus Cars") {
      router.showBasicAlert(text: "Coming soon")
    }
  }
  
  private var localization: some View {
    CustomButtonList(title: "Language") {
      router.showBasicAlert(text: "Coming soon")
    }
  }
  
  private var logOut: some View {
    CustomButtonList(title: "Log out") {
      Task {
        await vm.signOut()
      }
    }
  }
  
  private var author: some View {
    VStack(alignment: .leading) {
      Text("About Author")
        .font(.corporateARegular(size: 18))
      Divider()
      
      VStack(alignment: .leading, spacing: 8.0) {
        Text("Hello everyone! I'm Fazliddin, an iOS Developer passionate about building smooth and intuitive apps. Feel free to check out my GitHub profile to see what I've been working on!")
        Button {
          router.showSafari {
            URL(string: "https://github.com/Yuldshev")!
          }
        } label: {
          Text("Link")
            .foregroundStyle(.blue)
            .font(.arialBold(size: 14))
        }
        
      }
      .font(.arialBold(size: 14))
      .padding(.top, 8)
    }
  }
}

#Preview {
  ProfileView()
    .previewWithRouter()
}
