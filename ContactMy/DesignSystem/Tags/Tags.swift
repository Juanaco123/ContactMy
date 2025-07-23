//
//  Tags.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import Foundation

enum Tags: String, CaseIterable, Identifiable {
  var id: Self { self }
  case home = "Home"
  case personal = "Personal"
  case business = "Business"
}
