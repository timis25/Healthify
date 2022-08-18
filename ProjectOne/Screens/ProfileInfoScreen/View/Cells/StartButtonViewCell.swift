//
//  StartButtonViewCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 25/09/21.
//

import UIKit

protocol StartButtonViewCellProtocol {
    func startButtonDidTouch()
}

class StartButtonViewCell: UITableViewCell {
    let startButton = BaseButton()
    var delegate: StartButtonViewCellProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStartButton()
    }
    
    private func configureStartButton() {
        contentView.addSubview(startButton)
        
        startButton.setTitle(R.string.locale.profileStart(), for: .normal)
        startButton.backgroundColor = UIColor(hex: "#0077b6", alpha: 1)
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(150)
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalToSuperview().inset(30)
            make.left.equalTo(30)
            make.height.equalTo(50)
        }
    }
    
    @objc func startButtonAction() {
        delegate?.startButtonDidTouch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
