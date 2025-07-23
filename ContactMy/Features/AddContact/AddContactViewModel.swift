//
//  AddContactViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 22/07/25.
//

import Foundation

@Observable
class AddContactViewModel {
  var contact: ContactModel? = nil
  var contactName: String = ""
  var contactNumber: String = ""
  var selectedTagNumber: Tags = .personal
  var phoneNumberFields: [PhoneFieldModel] = []
  
  init() {
    let newField: PhoneFieldModel = PhoneFieldModel(
      text: "",
      placeholder: Constants.AddContact.addNumberPlaceholder.rawValue
    )
    phoneNumberFields.append(newField)
  }
  
  
}
