//
//  AddProductPresenter.swift.swift
//  ProjectOne
//
//  Created by Timur Israilov on 14/12/21.
//

import Foundation
import WidgetKit

protocol AddProductPresenterProtocol: AnyObject {
    init(view: AddProductViewProtocol, router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol)
    func addProduct(productName: String, callories: Int, fats: Int, carbs: Int, protein: Int)
}

class AddProductPresenter: AddProductPresenterProtocol {
    weak var view: AddProductViewProtocol?
    var router: RouterProtocol
    let dataManager: DataStoreManagerProtocol!

    required init(view: AddProductViewProtocol, router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol) {
        self.view = view
        self.router = router
        self.dataManager = dataStorageManager
    }

    func addProduct(productName: String, callories: Int, fats: Int, carbs: Int, protein: Int) {
        dataManager.addProduct(
            productName: productName,
            callories: callories,
            fats: fats,
            carbs: carbs,
            protein: protein
        )
        dataManager.updateDayliNutrion(newCallories: callories, newCarbs: carbs, newProtein: protein, newFats: fats)
    }
}

protocol AddProductViewProtocol: AnyObject {
}
