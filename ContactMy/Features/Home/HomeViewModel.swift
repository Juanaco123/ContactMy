//
//  HomeViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 17/07/25.
//

import Foundation

@Observable
class HomeViewModel {
  var service: ContactService = .shared
  var searchText: String = ""
  
  var filteredContactByName: [ContactModel] {
    guard !searchText.isEmpty else { return service.fetchContacts() }
    return service.fetchContacts().filter { contact in
      contact.name.lowercased().contains(searchText.lowercased())
    }
  }
}
