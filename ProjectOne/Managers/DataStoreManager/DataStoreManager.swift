//
//  DataStoreManager.swift
//  ProjectOne
//
//  Created by Timur Israilov on 05/09/21.
//

import Foundation
import CoreData

protocol DataStoreManagerProtocol {
    func setUser(name: String, birthDate: String, isMale: Bool, physicalState: Int, weight: Int, height: Int)
    func getUser() -> [User]?
    func getProduct() -> [Product]?
    func addProduct(productName: String, callories: Int, fats: Int, carbs: Int, protein: Int)
    func getDayliNutrion() -> [DayliNutrion]?
    func updateDayliNutrion(newCallories: Int, newCarbs: Int, newProtein: Int, newFats: Int)
}

final class DataStoreManager: DataStoreManagerProtocol {
    // MARK: - CoreData Stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Health")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Public methods
    func updateDayliNutrion(newCallories: Int, newCarbs: Int, newProtein: Int, newFats: Int) {
        if let data = getDayliNutrion()?.last {
            data.callories += Int32(newCallories)
            data.carbs += Int16(newCarbs)
            data.protein += Int16(newProtein)
            data.fats += Int16(newFats)
        } else {
            let product = DayliNutrion(context: viewContext)
            product.callories = Int32(newCallories)
            product.carbs = Int16(newCarbs)
            product.protein = Int16(newProtein)
            product.fats = Int16(newFats)
        }

        saveContext()
    }

    func getDayliNutrion() -> [DayliNutrion]? {
        var nutrion: [DayliNutrion]?

        do {
            if !UserSettings.isThisDay() {
                if let result = try? viewContext.fetch(DayliNutrion.fetchRequest()) {
                    for object in result {
                        viewContext.delete(object)
                    }
                    saveContext()
                    UserSettings.setNowDay(Date())
                }
            }
            try nutrion = viewContext.fetch(DayliNutrion.fetchRequest())
            return nutrion
        } catch let error as NSError {
            print("Could not fetch request \(error), \(error.userInfo)")
            return nutrion
        }
    }

    func addProduct(productName: String, callories: Int, fats: Int, carbs: Int, protein: Int) {
        let product = Product(context: viewContext)
        product.callorie = Int32(callories)
        product.protein = Int16(protein)
        product.carbs = Int16(carbs)
        product.fats = Int16(fats)
        product.name = productName
        product.date = Date()

        saveContext()
    }

    func getProduct() -> [Product]? {
        var products: [Product]?

        do {
            try products = viewContext.fetch(Product.fetchRequest())
            print(products)
            return products
        } catch let error as NSError {
            print("Could not fetch request \(error), \(error.userInfo)")
            return products
        }
    }

    func getUser() -> [User]? {
        var user: [User]?

        do {
            user = try viewContext.fetch(User.fetchRequest())
            print(user)
            return user
        } catch let error as NSError {
            print("Could not fetch request \(error), \(error.userInfo)")
            return user
        }
    }

    func setUser(name: String, birthDate: String, isMale: Bool, physicalState: Int, weight: Int, height: Int) {
        let user = User(context: viewContext)
        user.name = name
        user.physicalState = Int16(physicalState)
        user.birthday = birthDate
        user.isMale = isMale
        user.height = Int16(height)
        user.weight = Int16(weight)

        saveContext()
    }
}
