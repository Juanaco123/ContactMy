//
//  HomeViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 17/07/25.
//

import Foundation

@Observable
class HomeViewModel {
  var contacts: [Contact] = [
    Contact(
      name: "Contact1",
      phoneNumber: [
        PhoneNumber(tag: "Personal", number: "+1 (123)4678967")
      ],
      photo: nil
    ),
    Contact(
      name: "Contact2",
      phoneNumber: [
        PhoneNumber(tag: "Personal", number: "+1 (123)4678967")
      ],
      photo: nil
    ),
    Contact(
      name: "Contact3",
      phoneNumber: [
        PhoneNumber(tag: "Personal", number: "+1 (123)4678967")
      ],
      photo: nil
    ),
  ]
  var searchText: String = ""
  
  var filteredContactByName: [Contact] {
    guard !searchText.isEmpty else { return contacts }
    return contacts.filter { contact in
      contact.name.lowercased().contains(searchText.lowercased())
    }
  }
}
