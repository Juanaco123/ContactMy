//
//  ContactInfoViewModel.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 30/07/25.
//

import UIKit
import Contacts
import Foundation

@Observable
class ContactInfoViewModel {
  var contact: ContactModel? = nil
  var contactToShare: CNContact {
    let newShareContact: CNMutableContact = CNMutableContact()
    
    newShareContact.givenName = contact?.name ?? ""
    if let photo = contact?.photo {
      newShareContact.imageData = photo.jpegData(compressionQuality: 1.0)
    }
    
    contact?.phoneNumber.forEach { phone in
      let phoneNumber: CNLabeledValue = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: phone.number))
      newShareContact.phoneNumbers.append(phoneNumber)
    }
    return newShareContact
  }
  
  init(_ contact: ContactModel? = nil) {
    self.contact = contact
  }
  
  func call(to phoneNumber: String) {
    if let phoneURL = URL(string: "tel://\(formatPhone(phoneNumber))") {
      UIApplication.shared.open(phoneURL)
    }
  }
  
  func textContact() {
    let defaultMessage: String = "Hello \(contact?.name ?? "")!"
    
    if let phone = contact?.phoneNumber.first?.number {
      let cleanedPhone = phone.replacingOccurrences(of: " ", with: "")
      let urlWhatsApp: String = "https://wa.me/\(cleanedPhone)?text=\(defaultMessage)"
      
      if let urlString = urlWhatsApp.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
        
        if let url = URL(string: urlString) {
          if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
          } else {
            print("Cannot Open WhatsApp")
          }
        }
        
      }
    }
  }
  
  func shareContact() -> URL {
    let contact = contactToShare
    do {
      let vCardData: Data = try CNContactVCardSerialization.data(with: [contact])
      let fileName: String = "\(contact.givenName)"
      let temporaryDirectory: URL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName, conformingTo: .vCard)
      
      try vCardData.write(to: temporaryDirectory, options: .atomic)
      
      return temporaryDirectory
    } catch {
      print(String(describing: error))
      return URL(filePath: "")
    }
  }
  
  //MARK: - Private functions
  private func formatPhone(_ phone: String) -> String {
    let formattedPhone = phone.replacingOccurrences(of: " ", with: "")
    return formattedPhone
  }
}
