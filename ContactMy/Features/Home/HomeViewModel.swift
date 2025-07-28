//
//  HomeViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 17/07/25.
//

import Foundation

@Observable
class HomeViewModel {
  private var service: ContactService = .shared
  private var contacts: [ContactModel] = []
  
  var searchText: String = ""
  
  var filteredContactByName: [ContactModel] {
    guard !searchText.isEmpty else { return contacts }
    return contacts.filter { contact in
      contact.name.lowercased().contains(searchText.lowercased())
    }
  }
  
  func updateView() {
    contacts = service.fetchContacts()
  }
}
