//
//  ContactInfoViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 30/07/25.
//

import UIKit
import Foundation

@Observable
class ContactInfoViewModel {
  var contact: ContactModel? = nil
  
  init(_ contact: ContactModel? = nil) {
    self.contact = contact
  }
  
  func call(to phoneNumber: String) {
    if let phoneURL = URL(string: "tel://\(formatPhone(phoneNumber))") {
      UIApplication.shared.open(phoneURL)
    }
  }
  
  private func formatPhone(_ phone: String) -> String {
    let formattedPhone = phone.replacingOccurrences(of: " ", with: "")
    return formattedPhone
  }
}
