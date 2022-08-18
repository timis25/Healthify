//
//  ViewEx.swift
//  ProjectOne
//
//  Created by Timur Israilov on 27/09/21.
//

import UIKit

extension UIView {
    func configureCardViewGradient(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        let colorTop = colorTop.cgColor
        let colorBottom = colorBottom.cgColor
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.5, 1.0]
        
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 10
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
