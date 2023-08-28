//
//  DataStoreManager.swift
//  ProjectOne
//
//  Created by Timur Israilov on 05/09/21.
//

import Foundation
import CoreData

final class DataStoreManager: DataStoreManagerProtocol {
    // MARK: - Constants
    private enum Constants {
        static let persistentContainerName: String = "Health"
    }

    // MARK: - Private properties
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.persistentContainerName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext

    // MARK: - Private methods
    private func saveContext() {
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
    func updateDayliNutrition(_ model: NutritionModel) {
        if let data = getDayliNutrion()?.last {
            data.callories += Int32(model.callories)
            data.carbs += Int16(model.carbs)
            data.protein += Int16(model.proteins)
            data.fats += Int16(model.fats)
        } else {
            let product = DayliNutrionCoreData(context: viewContext)
            product.callories = Int32(model.callories)
            product.carbs = Int16(model.carbs)
            product.protein = Int16(model.proteins)
            product.fats = Int16(model.fats)
        }

        saveContext()
    }

    func getDayliNutrion() -> [DayliNutrionCoreData]? {
        var nutrion: [DayliNutrionCoreData]?

        do {
            if !UserSettings.isThisDay() {
                if let result = try? viewContext.fetch(DayliNutrionCoreData.fetchRequest()) {
                    for object in result {
                        viewContext.delete(object)
                    }
                    saveContext()
                    UserSettings.setNowDay(Date())
                }
            }
            try nutrion = viewContext.fetch(DayliNutrionCoreData.fetchRequest())
        } catch let error as NSError {
            fatalError("Could not fetch request \(error), \(error.userInfo)")
        }

        return nutrion
    }

    func addProduct(_ model: ProductModel) {
        let product = ProductCoreData(context: viewContext)
        product.callorie = Int32(model.nutrition.callories)
        product.protein = Int16(model.nutrition.proteins)
        product.carbs = Int16(model.nutrition.carbs)
        product.fats = Int16(model.nutrition.fats)
        product.name = model.productName
        product.date = Date()

        saveContext()
    }

    func getProduct() -> [ProductCoreData]? {
        var products: [ProductCoreData]?

        do {
            try products = viewContext.fetch(ProductCoreData.fetchRequest())
        } catch let error as NSError {
            fatalError("Could not fetch request \(error), \(error.userInfo)")
        }
        return products
    }

    func getUser() -> [UserCoreData]? {
        var user: [UserCoreData]?

        do {
            try user = viewContext.fetch(UserCoreData.fetchRequest())
        } catch let error as NSError {
            fatalError("Could not fetch request \(error), \(error.userInfo)")
        }

        return user
    }

    func setUser(_ user: UserCoreData) {
        let user = UserCoreData(context: viewContext)
        user.name = user.name
        user.physicalState = user.physicalState
        user.birthday = user.birthday
        user.gender = user.gender
        user.height = user.height
        user.weight = user.weight

        saveContext()
    }
}
