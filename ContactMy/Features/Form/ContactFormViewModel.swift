//
//  AddContactViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import SwiftUI
import Foundation

struct PhoneNumberdArg: Identifiable {
  var id: UUID = UUID()
  var number: String = ""
  var tag: Tags = .personal
}


@MainActor
@Observable
class ContactFormViewModel {
  private var service: ContactService = .shared
  
  var isUpdateContact: Bool = false
  var contactName: String = ""
  var selectedPhoto: UIImage? = nil
  var phoneNumberFields: [PhoneNumberdArg] = []
  
  func addContact() {
    let phoneNumbers: [PhoneNumberModel] = addPhoneNumber()
    
    let newContact: ContactModel = ContactModel(
      name: contactName,
      phoneNumber: phoneNumbers,
      photo: selectedPhoto
    )
    
    service.createContact(newContact)
  }
  
  func addNewPhoneField() {
    let newField: PhoneNumberdArg = PhoneNumberdArg()
    phoneNumberFields.append(newField)
  }
  
  func removePhoneField(with id: UUID) {
    phoneNumberFields.removeAll { phoneField in
      phoneField.id == id
    }
  }
  
  private func addPhoneNumber() -> [PhoneNumberModel] {
    var phoneNumbers: [PhoneNumberModel] = []
    phoneNumberFields.forEach { field in
      phoneNumbers.append(
        PhoneNumberModel(
          tag: field.tag.rawValue,
          number: field.number
        )
      )
    }
    return phoneNumbers
  }
}
