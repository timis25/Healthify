//
//  AddProductPresenter.swift.swift
//  ProjectOne
//
//  Created by Timur Israilov on 14/12/21.
//

import Foundation
import WidgetKit

protocol AddProductPresenterProtocol: AnyObject {
    func addProduct(_ productModel: ProductModel)
}

final class AddProductPresenter: AddProductPresenterProtocol {
    // MARK: - Private properties
    private var router: RouterProtocol
    private let dataManager: DataStoreManagerProtocol

    // MARK: - Public properties
    weak var view: AddProductViewProtocol?

    // MARK: - Init
    init(router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol) {
        self.router = router
        self.dataManager = dataStorageManager
    }

    // MARK: - Public methods
    func addProduct(_ productModel: ProductModel) {
        dataManager.addProduct(productModel)
        router.pop()
    }
}
