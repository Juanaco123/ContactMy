//
//  Contact+CoreDataProperties.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 28/07/25.
//
//

import Foundation
import CoreData


extension Contact {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
    return NSFetchRequest<Contact>(entityName: "Contact")
  }
  
  @NSManaged public var id: UUID?
  @NSManaged public var name: String?
  @NSManaged public var photo: Data?
  @NSManaged public var phoneNumber: NSSet?
  
  public var wrappedName: String { name ?? "" }
  
  public var wrappedphoto: Data { photo ?? Data() }
  
  public var phoneNumberArray: [PhoneNumber] {
    let phoneNumberSet = phoneNumber as? Set<PhoneNumber> ?? []
    return phoneNumberSet.sorted { $0.id < $1.id }
  }
}

// MARK: Generated accessors for phoneNumber
extension Contact {
  
  @objc(insertObject:inPhoneNumberAtIndex:)
  @NSManaged public func insertIntoPhoneNumber(_ value: PhoneNumber, at idx: Int)
  
  @objc(removeObjectFromPhoneNumberAtIndex:)
  @NSManaged public func removeFromPhoneNumber(at idx: Int)
  
  @objc(insertPhoneNumber:atIndexes:)
  @NSManaged public func insertIntoPhoneNumber(_ values: [PhoneNumber], at indexes: NSIndexSet)
  
  @objc(removePhoneNumberAtIndexes:)
  @NSManaged public func removeFromPhoneNumber(at indexes: NSIndexSet)
  
  @objc(replaceObjectInPhoneNumberAtIndex:withObject:)
  @NSManaged public func replacePhoneNumber(at idx: Int, with value: PhoneNumber)
  
  @objc(replacePhoneNumberAtIndexes:withPhoneNumber:)
  @NSManaged public func replacePhoneNumber(at indexes: NSIndexSet, with values: [PhoneNumber])
  
  @objc(addPhoneNumberObject:)
  @NSManaged public func addToPhoneNumber(_ value: PhoneNumber)
  
  @objc(removePhoneNumberObject:)
  @NSManaged public func removeFromPhoneNumber(_ value: PhoneNumber)
  
  @objc(addPhoneNumber:)
  @NSManaged public func addToPhoneNumber(_ values: NSOrderedSet)
  
  @objc(removePhoneNumber:)
  @NSManaged public func removeFromPhoneNumber(_ values: NSOrderedSet)
  
}

extension Contact : Identifiable {
  
}
