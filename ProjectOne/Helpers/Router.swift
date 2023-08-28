//
//  Router.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get  set }
    var assembly: AssemblyProtocol? { get  set }
}

protocol RouterProtocol: RouterMain {
    func initMainScreens()
    func showInfoProfileSetting(isShowAfterOnbording: Bool)
    func initAddProductScreen()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assembly: AssemblyProtocol?
    var dataStorage: DataStoreManagerProtocol
    var tabBarController: UITabBarController?
    var window: UIWindow
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
