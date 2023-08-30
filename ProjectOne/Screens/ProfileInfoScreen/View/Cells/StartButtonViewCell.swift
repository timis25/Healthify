//
//  StartButtonViewCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 25/09/21.
//

import UIKit

protocol StartButtonViewCellProtocol: AnyObject {
    func startButtonDidTouch()
}

final class StartButtonViewCell: UITableViewCell {
    // MARK: - UI Elements
    private let startButton = BaseButton()

    // MARK: - Public properties
    weak var delegate: StartButtonViewCellProtocol?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureStartButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private methods
    private func configureStartButton() {
        contentView.addSubview(startButton)

        startButton.setTitle(R.string.profileInfoLocale.profileStart(), for: .normal)
        startButton.backgroundColor = UIColor(hex: "#0077b6", alpha: 1)
        startButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)

        startButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.bottom.equalToSuperview().offset(-20)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }

    // MARK: - Actions
    @objc func startButtonAction() {
        delegate?.startButtonDidTouch()
    }
}
