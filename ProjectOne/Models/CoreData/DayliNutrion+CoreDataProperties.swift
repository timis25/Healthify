//
//  DayliNutrion+CoreDataProperties.swift
//  ProjectOne
//
//  Created by Timur Israilov on 13/10/21.
//
//

import Foundation
import CoreData

extension DayliNutrion {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayliNutrion> {
        return NSFetchRequest<DayliNutrion>(entityName: "DayliNutrion")
    }

    @NSManaged public var callories: Int32
    @NSManaged public var carbs: Int16
    @NSManaged public var protein: Int16
    @NSManaged public var fats: Int16
}

extension DayliNutrion: Identifiable {
}
