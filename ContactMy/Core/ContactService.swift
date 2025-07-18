//
//  ContactService.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 14/07/25.
//

import SwiftUI
import CoreData

struct ContactService {
  static let shared = ContactService()
  
  let container: NSPersistentContainer
  
  private var context: NSManagedObjectContext { container.viewContext }
  // MARK: - Constants
  private let persistenceContainer: String = "ContactMy"
  private let entityName: String = "Contact"
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: persistenceContainer)
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    container.viewContext.automaticallyMergesChangesFromParent = true
  }
  
  func fetchContacts() -> [ContactModel] {
    let request = NSFetchRequest<Contact>(entityName: entityName)
    do {
      let fetchedContact = try context.fetch(request)
      
      let contactModel: [ContactModel] = fetchedContact.map { contact in
        let name: String? = contact.name ?? ""
        let photo = contact.photo ?? Data()
        let phone: [PhoneNumberModel] = ([contact.phoneNumber] as? [PhoneNumber])?.map { phoneNumber in
          PhoneNumberModel(
            tag: phoneNumber.tag ?? "",
            number: phoneNumber.number ?? ""
          )
        } ?? []
        
        return ContactModel(
          name: name!,
          phoneNumber: phone,
          photo: Image(uiImage: UIImage(data: photo)!)
        )
      }
      
      return contactModel
    } catch {
      print("🛑 Failed to fetch contacts: \(error)")
      return []
    }
  }
  
  func createContact(_ contactModel: ContactModel) {
    let newContact: Contact = Contact(context: context)
    newContact.name = contactModel.name
    newContact.photo = contactModel.photo?.transformAsData()
    
    for phoneNumber in contactModel.phoneNumber {
      let phoneNumber: PhoneNumber = PhoneNumber(context: context)
      phoneNumber.tag = phoneNumber.tag
      phoneNumber.number = phoneNumber.number
    }
    saveContext()
  }
  
  func saveContext() {
    do {
      try context.save()
    } catch {
      print("🛑 Failed to save context: \(error)")
    }
  }
  
}
