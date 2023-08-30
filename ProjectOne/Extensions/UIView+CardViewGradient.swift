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
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorTop, colorBottom]

        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
