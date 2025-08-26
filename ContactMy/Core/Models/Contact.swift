//
//  Contact.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import Foundation

struct ContactModel: Identifiable {
  var id: UUID = UUID()
  var name: String
  var phoneNumber: [PhoneNumberModel]
  var photo: UIImage?
  
  var wrapPhoto: UIImage {
    photo ?? UIImage()
  }
  
  init(
    id: UUID = UUID(),
    name: String,
    phoneNumber: [PhoneNumberModel],
    photo: UIImage? = nil
  ) {
    self.id = id
    self.name = name
    self.phoneNumber = phoneNumber
    self.photo = photo
  }
}
