//
//  AddContactViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import SwiftUI
import Foundation

struct PhoneNumberArg: Identifiable {
  var id: UUID = UUID()
  var number: String = ""
  var tag: Tags = .personal
}


@MainActor
@Observable
class ContactFormViewModel {
  private var service: ContactService = .shared
  
  var contact: ContactModel? = nil
  var contactName: String = ""
  var selectedPhoto: UIImage? = nil
  var phoneNumberFields: [PhoneNumberArg] = []
  
  init(_ contact: ContactModel? = nil) {
    if let contact = contact {
      self.contact = contact
      
      contact.phoneNumber.forEach { phone in
        self.phoneNumberFields.append(PhoneNumberArg(
          number: phone.number,
          tag: Tags(rawValue: phone.tag) ?? Tags.personal
        ))
      }
      
    }
  }
  
  func addContact() {
    let phoneNumbers: [PhoneNumberModel] = addPhoneNumber()
    
    let newContact: ContactModel = ContactModel(
      name: contactName,
      phoneNumber: phoneNumbers,
      photo: selectedPhoto
    )
    
    service.createContact(newContact)
  }
  
  func updateContact() {
    guard let existingContact = contact else { return }
    let phoneNumbers: [PhoneNumberModel] = addPhoneNumber()
    
    let updatedContact: ContactModel = ContactModel(
      id: existingContact.id,
      name: contactName.isEmpty ? existingContact.name: contactName,
      phoneNumber: phoneNumbers,
      photo: selectedPhoto ?? existingContact.photo
    )
    service.updateContact(updatedContact)
  }
  
  func deleteContact() {
    guard let contact = contact else { return }
    service.deleteContact(contact)
    self.contact = nil
    contactName = ""
    selectedPhoto = nil
    phoneNumberFields = []
  }
  
  func addNewPhoneField() {
    let newField: PhoneNumberArg = PhoneNumberArg()
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
