//
//  Router.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import UIKit

final class Router: RouterProtocol {
    // MARK: - Public properties
    var navigationController: UINavigationController?
    var assembly: AssemblyProtocol?
    // MARK: - Private properties
    private var dataStorage: DataStoreManagerProtocol
    private var window: UIWindow

    // MARK: - Init
    init(
        navigationController: UINavigationController,
        assembly: AssemblyProtocol,
        dataStorage: DataStoreManagerProtocol,
        window: UIWindow
    ) {
        self.navigationController = navigationController
        self.assembly = assembly
        self.dataStorage = dataStorage
        self.window = window
    }

    // MARK: - Public methods
    func pop() {
        navigationController?.popViewController(animated: true)
    }

    func initMainScreens() {
        if let navigationController = navigationController {
            guard let mainViewController = assembly?.createMain(router: self, dataStorage: dataStorage) else { return }
            window.rootViewController = navigationController
            navigationController.setViewControllers([mainViewController], animated: true)
        }
    }

    func initAddProductScreen() {
        guard let navigationController = navigationController else { return }
        guard let addProductViewController = assembly?.createAddProduct(
            router: self,
            dataStorage: dataStorage
        ) else { return }
        navigationController.pushViewController(addProductViewController, animated: true)
    }

    func showInfoProfileSetting(isShowAfterOnbording: Bool) {
        if let navigationController = navigationController {
            guard let profileInfoViewController = assembly?.createProfileInfo(
                router: self,
                dataStorage: dataStorage,
                isShowAfterOnbording: isShowAfterOnbording
            ) else { return }
            window.rootViewController = navigationController
            navigationController.setViewControllers([profileInfoViewController], animated: true)
        }
    }
}
