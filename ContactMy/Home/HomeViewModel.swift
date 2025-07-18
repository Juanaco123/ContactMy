//
//  HomeViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 17/07/25.
//

import Foundation

@Observable
class HomeViewModel {
  var contacts: [ContactModel] = [
    ContactModel(
      name: "Contact1",
      phoneNumber: [
        PhoneNumberModel(tag: "Personal", number: "+1 (123)4678967")
      ],
      photo: nil
    ),
    ContactModel(
      name: "Contact2",
      phoneNumber: [
        PhoneNumberModel(tag: "Personal", number: "+1 (123)4678967")
      ],
      photo: nil
    ),
    ContactModel(
      name: "Contact3",
      phoneNumber: [
        PhoneNumberModel(tag: "Personal", number: "+1 (123)4678967")
      ],
      photo: nil
    ),
  ]
  var searchText: String = ""
  
  var filteredContactByName: [ContactModel] {
    guard !searchText.isEmpty else { return contacts }
    return contacts.filter { contact in
      contact.name.lowercased().contains(searchText.lowercased())
    }
  }
}
