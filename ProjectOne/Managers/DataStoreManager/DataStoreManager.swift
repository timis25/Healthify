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
    func addProduct(_ model: ProductModel) {
        let product = ProductCoreData(context: viewContext)

        product.name = model.productName
        product.date = Date()
        product.nutritionCoreData = NutritionCoreData(context: viewContext)
        product.nutritionCoreData?.callories = Int32(model.nutrition.callories)
        product.nutritionCoreData?.protein = Int16(model.nutrition.proteins)
        product.nutritionCoreData?.carbs = Int16(model.nutrition.carbs)
        product.nutritionCoreData?.fats = Int16(model.nutrition.fats)
        saveContext()
    }

    func getProduct() -> [ProductCoreData]? {
        var products: [ProductCoreData]?

        do {
            try products = viewContext.fetch(ProductCoreData.fetchRequest())
            products = products?.filter({ $0.date?.toDate() == Date().toDate() })
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
