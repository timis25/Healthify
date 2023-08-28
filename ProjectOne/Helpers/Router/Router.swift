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
    private var tabBarController: UITabBarController?
    private var window: UIWindow

    // MARK: - Init
    init(
        navigationController: UINavigationController,
        assembly: AssemblyProtocol,
        dataStorage: DataStoreManagerProtocol,
        window: UIWindow,
        tabBarController: UITabBarController
    ) {
        self.navigationController = navigationController
        self.assembly = assembly
        self.dataStorage = dataStorage
        self.window = window
        self.tabBarController = tabBarController
    }

    // MARK: - Public methods
    func initMainScreens() {
        if let navigationController = navigationController {
            let window = UIApplication.shared.windows[0]
            window.rootViewController = tabBarController
            guard let mainViewController = assembly?.createMain(router: self, dataStorage: dataStorage) else { return }
            navigationController.setViewControllers([mainViewController], animated: true)
            tabBarController?.setViewControllers([navigationController], animated: true)
            tabBarController?.selectedIndex = 0
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
            navigationController.setViewControllers([profileInfoViewController], animated: true)
        }
    }
}
