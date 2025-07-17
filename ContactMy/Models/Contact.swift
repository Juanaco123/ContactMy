//
//  Contact.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 15/07/25.
//

import Foundation
import SwiftUICore

struct Contact: Identifiable {
  let id: UUID = UUID()
  let name: String
  let phoneNumber: [PhoneNumber]
  let photo: Image?
}
