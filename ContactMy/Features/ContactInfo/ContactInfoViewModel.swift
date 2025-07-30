//
//  ContactInfoViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 30/07/25.
//

import Foundation

@Observable
class ContactInfoViewModel {
  var contact: ContactModel? = nil
  
  init(_ contact: ContactModel? = nil) {
    self.contact = contact
  }
  
  func onCall(to phone: String) -> URL? {
    let phoneNumberFormat: String = phone.replacingOccurrences(of: " ", with: "")
    let phone: String = "tel://\(phoneNumberFormat)"
    guard let phoneUrl: URL = URL(string: phone) else {
      print("❌ Number unreachable")
      return nil
    }
    return phoneUrl
  }
}
