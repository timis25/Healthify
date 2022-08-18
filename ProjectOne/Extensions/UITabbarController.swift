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
        if #available(iOS 13.0, *) {
            let appearance = tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            tabBar.standardAppearance = appearance
        } else {
            tabBar.barTintColor = .white
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
    }
}
