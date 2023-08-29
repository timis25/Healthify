//
//  ModulBuilder.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import UIKit

final class Assembly: AssemblyProtocol {
    // MARK: - Public methods
    func createProfileInfo(
        router: RouterProtocol,
        dataStorage: DataStoreManagerProtocol,
        isShowAfterOnbording: Bool
    ) -> UIViewController {
        let presenter = ProfileInfoPresenter(router: router, dataStorageManager: dataStorage)
        let view = ProfileInfoViewController(presenter: presenter, isShowAfterOnbording: isShowAfterOnbording)
        presenter.view = view
        return view
    }

    func createMain(router: RouterProtocol, dataStorage: DataStoreManagerProtocol) -> UIViewController {
        let presenter = MainPresenter(router: router, dataStorageManager: dataStorage)
        let view = MainViewController(presenter: presenter)
        presenter.view = view
        return view
    }

    func createAddProduct(router: RouterProtocol, dataStorage: DataStoreManagerProtocol) -> UIViewController {
        let presenter = AddProductPresenter(router: router, dataStorageManager: dataStorage)
        let view = AddProductViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}
