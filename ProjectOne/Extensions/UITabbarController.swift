//
//  UITabbarController.swift
//  ProjectOne
//
//  Created by Timur Israilov on 25/01/22.
//

import Foundation
import UIKit

extension UITabBarController {
    func setDefaultApearance() {
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance
    }
}
