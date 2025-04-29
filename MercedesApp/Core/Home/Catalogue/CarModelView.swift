import SwiftUI

struct CarModelView: View {
  @EnvironmentObject var vm: FavoriteViewModel
  @Environment(\.router) var router
  var cars: [CarDisplay]
  
  // Разбиваем список по 2 элемента
  private var rows: [[CarDisplay]] {
    var result: [[CarDisplay]] = []
    let filtered = cars.filter { car in
      !(car.name.isEmpty || car.imageURL == nil) }
    var currentRow: [CarDisplay] = []
    
    for car in filtered {
      currentRow.append(car)
      if currentRow.count == 2 {
        result.append(currentRow)
        currentRow = []
      }
    }
    if !currentRow.isEmpty {
      result.append(currentRow)
    }
    return result
  }
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading, spacing: 24) {
        ForEach(rows.indices, id: \.self) { rowIndex in
          HStack(spacing: 24) {
            ForEach(rows[rowIndex], id: \.id) { car in
              Button {
                router.showScreen(.push) { _ in
                  CarDetailView(car: car)
                    .environmentObject(vm)
                    .navigationWithInline(title: "")
                }
              } label: {
                CarModelCartView(car: car)
                  .frame(maxWidth: .infinity)
                  .frame(height: 200)
                  .environmentObject(vm)
              }
            }
            
            if rows[rowIndex].count == 1 {
              Spacer()
            }
          }
        }
      }
      .padding(.horizontal, 24)
      .padding(.top)
      .onChange(of: vm.message) { _, new in
        switch new {
          case .error(let text):
            router.showErrorModal(message: text)
          case .success(let text):
            router.showSuccessModal(message: text)
        }
      }
    }
    .background(.appLightGray)
  }
}




