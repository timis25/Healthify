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
    func addProduct(_ productModel: ProductModel)
}

final class AddProductPresenter: AddProductPresenterProtocol {
    // MARK: - Private properties
    private weak var view: AddProductViewProtocol?
    private var router: RouterProtocol
    private let dataManager: DataStoreManagerProtocol

    // MARK: - Init
    init(view: AddProductViewProtocol, router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol) {
        self.view = view
        self.router = router
        self.dataManager = dataStorageManager
    }

    // MARK: - Public methods
    func addProduct(_ productModel: ProductModel) {
        dataManager.addProduct(productModel)
        dataManager.updateDayliNutrition(productModel.nutrition)
    }
}
