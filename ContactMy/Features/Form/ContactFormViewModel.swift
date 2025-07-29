//
//  AddContactViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import SwiftUI
import Foundation

@MainActor
@Observable
class ContactFormViewModel {
  private var service: ContactService = .shared
  
  var isUpdateContact: Bool = false
  var contactName: String = ""
  var selectedPhoto: UIImage? = nil
  var selectedTagNumber: Tags = .personal
  var phoneNumberFields: [FieldIdentifier] = []
  
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
    let newField: FieldIdentifier = FieldIdentifier()
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
          tag: selectedTagNumber.rawValue,
          number: field.number
        )
      )
    }
    return phoneNumbers
  }
}
