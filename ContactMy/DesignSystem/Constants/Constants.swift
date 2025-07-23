//
//  Constants.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 17/07/25.
//

import Foundation

public enum Constants {
  enum Home: String {
    case title = "ContactMy"
    case searchPlaceholder = "Search contact..."
  }
  
  enum ShowContactInfo: String {
    case close = "Close"
    case edit = "Edit"
    case linkMessage = "Send message"
    case linkCall = "Call contact"
    case linkShare = "Share contact"
    case linkFavorite = "Add to favorites"
  }
  
  enum AddContact: String {
    case cancel = "Cancel"
    case add = "Add"
    case addNamePlaceholder = "Add a name here..."
    case addNumberPlaceholder = "Add a number here..."
    case nameSubtitle = "Name"
    case phoneSubtitle = "Phone"
    case buttonAddPhone = "Add phone"
  }
  
  enum EditContact: String {
    case cancel = "Cancel"
    case done = "Done"
    case buttonLabel = "Delete contact"
    case buttonAddPhone = "Add phone"
  }
}
