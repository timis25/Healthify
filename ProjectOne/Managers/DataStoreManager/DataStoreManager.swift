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
            let product = NutritionCoreData(context: viewContext)
            product.callories = Int32(model.callories)
            product.carbs = Int16(model.carbs)
            product.protein = Int16(model.proteins)
            product.fats = Int16(model.fats)
        }

        saveContext()
    }

    func getDayliNutrion() -> [NutritionCoreData]? {
        var nutrion: [NutritionCoreData]?

        do {
            if !UserSettings.isThisDay() {
                if let result = try? viewContext.fetch(NutritionCoreData.fetchRequest()) {
                    for object in result {
                        viewContext.delete(object)
                    }
                    saveContext()
                    UserSettings.setNowDay(Date())
                }
            }
            try nutrion = viewContext.fetch(NutritionCoreData.fetchRequest())
        } catch let error as NSError {
            fatalError("Could not fetch request \(error), \(error.userInfo)")
        }

        return nutrion
    }

    func addProduct(_ model: ProductModel) {
        let product = ProductCoreData(context: viewContext)
        let nutritionCoreData = NutritionCoreData(context: viewContext)
        nutritionCoreData.callories = Int32(model.nutrition.callories)
        nutritionCoreData.protein = Int16(model.nutrition.proteins)
        nutritionCoreData.carbs = Int16(model.nutrition.carbs)
        nutritionCoreData.fats = Int16(model.nutrition.fats)

        product.name = model.productName
        product.date = Date()
        product.nutritionCoreData = nutritionCoreData

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

    func setUser(_ model: UserModel) {
        let user = UserCoreData(context: viewContext)
        user.name = model.name
        user.physicalState = Int16(model.physicalState.rawValue)
        user.birthday = model.birthday
        user.gender = Int16(model.gender.rawValue)
        user.height = Int16(model.height)
        user.weight = Int16(model.weight)

        saveContext()
    }
}
