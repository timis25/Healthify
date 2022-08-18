//
//  ModulBuilder.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import UIKit

protocol AssemblyProtocol {
    func createMain(router: RouterProtocol, dataStorage: DataStoreManagerProtocol) -> UIViewController
    func createProfileInfo(router: RouterProtocol, dataStorage: DataStoreManagerProtocol, isShowAfterOnbording: Bool) -> UIViewController
    func createAddProduct(router: RouterProtocol, dataStorage: DataStoreManagerProtocol) -> UIViewController
}

class Assembly: AssemblyProtocol {
    
    func createProfileInfo(router: RouterProtocol, dataStorage: DataStoreManagerProtocol, isShowAfterOnbording: Bool) -> UIViewController {
        let view = ProfileInfoViewController(isShowAfterOnbording: isShowAfterOnbording)
        let presenter = ProfileInfoPresenter(view: view, router: router, dataStorageManager: dataStorage)
        view.presenter = presenter
        return view
    }
    
    func createMain(router: RouterProtocol, dataStorage: DataStoreManagerProtocol) -> UIViewController {
        let view = MainViewController()
        let presenter = MainPresenter(view: view, router: router, dataStorageManager: dataStorage)
        view.presenter = presenter
        return view
    }
    
    func createAddProduct(router: RouterProtocol, dataStorage: DataStoreManagerProtocol) -> UIViewController {
        let view = AddProductViewController()
        let presenter = AddProductPresenter(view: view, router: router, dataStorageManager: dataStorage)
        view.presenter = presenter
        return view
    }
}
