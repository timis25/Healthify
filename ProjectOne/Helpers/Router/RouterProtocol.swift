//
//  RouterProtocol.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation
import UIKit

protocol RouterProtocol {
    var navigationController: UINavigationController? { get  set }
    var assembly: AssemblyProtocol? { get  set }
    func initMainScreens()
    func showInfoProfileSetting(isShowAfterOnbording: Bool)
    func initAddProductScreen()
    func pop()
}
