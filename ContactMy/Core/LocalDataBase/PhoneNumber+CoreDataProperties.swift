//
//  PhoneNumber+CoreDataProperties.swift
//  ContactMy
//
//  Created by Juan Camilo Victoria Pacheco on 28/07/25.
//
//

import Foundation
import CoreData


extension PhoneNumber {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneNumber> {
    return NSFetchRequest<PhoneNumber>(entityName: "PhoneNumber")
  }
  
  @NSManaged public var id: UUID?
  @NSManaged public var number: String?
  @NSManaged public var tag: String?
  @NSManaged public var contact: NSSet?
  
  public var wrappedNumber: String { number ?? "" }
  
  public var wrappedTag: String { tag ?? "" }
  
  public var contactArray: [Contact] {
    let contactSet = contact as? Set<Contact> ?? []
    return contactSet.sorted { $0.id < $1.id }
  }
}

// MARK: Generated accessors for contact
extension PhoneNumber {
  
  @objc(insertObject:inContactAtIndex:)
  @NSManaged public func insertIntoContact(_ value: Contact, at idx: Int)
  
  @objc(removeObjectFromContactAtIndex:)
  @NSManaged public func removeFromContact(at idx: Int)
  
  @objc(insertContact:atIndexes:)
  @NSManaged public func insertIntoContact(_ values: [Contact], at indexes: NSIndexSet)
  
  @objc(removeContactAtIndexes:)
  @NSManaged public func removeFromContact(at indexes: NSIndexSet)
  
  @objc(replaceObjectInContactAtIndex:withObject:)
  @NSManaged public func replaceContact(at idx: Int, with value: Contact)
  
  @objc(replaceContactAtIndexes:withContact:)
  @NSManaged public func replaceContact(at indexes: NSIndexSet, with values: [Contact])
  
  @objc(addContactObject:)
  @NSManaged public func addToContact(_ value: Contact)
  
  @objc(removeContactObject:)
  @NSManaged public func removeFromContact(_ value: Contact)
  
  @objc(addContact:)
  @NSManaged public func addToContact(_ values: NSOrderedSet)
  
  @objc(removeContact:)
  @NSManaged public func removeFromContact(_ values: NSOrderedSet)
  
}

extension PhoneNumber : Identifiable {
  
}
