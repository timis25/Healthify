//
//  FoodEatViewCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 16/09/21.
//

import UIKit

class FoodEatViewCell: UITableViewCell {
    // MARK: - UIElemets
    private let cardView = UIView()
    private let dateLabel = UILabel()
    private let dishNameLabel = UILabel()
    private let fatsLabel = UILabel()
    private let carbsLabel = UILabel()
    private let proteinLabel = UILabel()
    private let calloriesLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    // MARK: - Public
    public func setData(callories: Int, productName: String, date: String) {
        calloriesLabel.text = "\(callories)\(R.string.locales.unitCallories())"
        dishNameLabel.text = productName
        dateLabel.text = date
    }

    // MARK: - Private

    private func setup() {
        configureCardView()
        configureDishNameLabel()
        configureDateLabel()
        configureCalloriesLabel()
    }

    private func configureCalloriesLabel() {
        cardView.addSubview(calloriesLabel)

        calloriesLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        calloriesLabel.textColor = .black
        calloriesLabel.textAlignment = .right

        calloriesLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(dishNameLabel.snp.width).inset(50)
            make.right.equalTo(-16)
        }
    }

    private func configureDateLabel() {
        cardView.addSubview(dateLabel)

        dateLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 16, weight: .thin)

        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(dishNameLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-10)
            make.left.equalTo(16)
        }
    }

    private func configureDishNameLabel() {
        cardView.addSubview(dishNameLabel)

        dishNameLabel.textColor = .black
        dishNameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        dishNameLabel.numberOfLines = 0
        dishNameLabel.lineBreakMode = .byWordWrapping

        dishNameLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(16)
            make.width.equalToSuperview().inset(85)
        }
    }

    private func configureCardView() {
        contentView.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOpacity = 8

        cardView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(9)
            make.left.equalTo(9)
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-5)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
