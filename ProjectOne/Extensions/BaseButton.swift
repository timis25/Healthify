//
//  BaseButton.swift
//  ProjectOne
//
//  Created by Timur Israilov on 25/09/21.
//

import UIKit

public class BaseButton: UIButton {
    public init() {
        super.init(frame: CGRect.zero)
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        layer.cornerRadius = 25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 1.8
        layer.shadowOpacity = 0.3
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchDown () {
        alpha = 0.5
    }
    
    @objc func touchUp () {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    @objc func touchUpOutside() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
}
