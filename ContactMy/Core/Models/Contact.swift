//
//  Contact.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import SwiftUI
import Foundation

struct ContactModel: Identifiable {
  let id: UUID = UUID()
  var name: String
  var phoneNumber: [PhoneNumberModel]
  var photo: UIImage?
  
  var wrapPhoto: UIImage {
    photo ?? UIImage()
  }
}
