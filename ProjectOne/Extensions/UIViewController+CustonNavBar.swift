//
//  UIViewController+CustonNavBar.swift
//  ProjectOne
//
//  Created by Timur Israilov on 25/01/22.
//

import Foundation
import UIKit

extension UIViewController {
    func configureStandartNavBar() {
        let navBar = self.navigationController!.navigationBar
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.shadowColor = .clear
            appearance.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 17),
                .foregroundColor: UIColor.black]
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
            
        } else {
            navBar.isTranslucent = false
            navBar.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 17),
                .foregroundColor: UIColor.black]
            navBar.barTintColor = .white
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
        }
    }
}
