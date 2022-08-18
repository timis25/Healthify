//
//  User+CoreDataProperties.swift
//  ProjectOne
//
//  Created by Timur Israilov on 05/09/21.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var height: Int16
    @NSManaged public var name: String?
    @NSManaged public var physicalState: Int16
    @NSManaged public var weight: Int16
    @NSManaged public var birthday: String?
    @NSManaged public var isMale: Bool

}

extension User : Identifiable {

}
