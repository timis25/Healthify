//
//  Product+CoreDataProperties.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/10/21.
//
//

import Foundation
import CoreData

extension Product {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var callorie: Int32
    @NSManaged public var protein: Int16
    @NSManaged public var carbs: Int16
    @NSManaged public var fats: Int16
    @NSManaged public var name: String?
    @NSManaged public var describtion: String?
    @NSManaged public var image: Data?
    @NSManaged public var date: Date?
}

extension Product: Identifiable {
}
