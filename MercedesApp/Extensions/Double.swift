import Foundation

extension Double {
  var formattedPrice: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.groupingSeparator = " "
    formatter.maximumFractionDigits = 0
    let formatted = formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    return "\(formatted) €"
  }
}

extension Int {
  var formattedHP: String {
    "\(self) HP"
  }
  
  var formattedTopSpeed: String {
    "\(Int(self)) km/h"
  }
  
  var formattedTorque: String {
    "\(Int(self)) Nm"
  }
  
  var formattedDimensions: String {
    let sm = self / 10
    return "\(sm) sm"
  }
}
