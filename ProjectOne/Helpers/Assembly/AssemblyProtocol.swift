//
//  AssemblyProtocol.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation
import UIKit

protocol AssemblyProtocol {
    func createMain(router: RouterProtocol, dataStorage: DataStoreManagerProtocol) -> UIViewController
    func createProfileInfo(
        router: RouterProtocol,
        dataStorage: DataStoreManagerProtocol,
        isShowAfterOnbording: Bool
    ) -> UIViewController
    func createAddProduct(router: RouterProtocol, dataStorage: DataStoreManagerProtocol) -> UIViewController
}
