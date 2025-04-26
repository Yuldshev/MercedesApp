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
  
  var formattedHP: String {
    "\(Int(self)) HP"
  }
  
  var formattedTopSpeed: String {
    "\(Int(self)) km/h"
  }
  
  var formattedTorque: String {
    "\(Int(self)) Nm"
  }
  
  var formattedDimensions: String {
    let sm = self / 10
    return "\(sm.clean) sm"
  }
  
  var clean: String {
    let IntValue = Int(self)
    if Double(IntValue) == self {
      return "\(IntValue)"
    } else {
      return String(format: "%.1f", self)
    }
  }
}
