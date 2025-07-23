//
//  PhoneNumber.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import Foundation

struct PhoneNumberModel: Identifiable {
  let id: UUID = UUID()
  var tag: String
  var number: String
}
