//
//  CalloriesViewCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 16/09/21.
//

import UIKit

final class CalloriesViewCell: UITableViewCell {
    // MARK: - UI Elemets
    private let cardView = UIView()
    private let calloriesLabel = UILabel()
    private let calloriesCountLabel = UILabel()
    private let rateCalloriesLabel = UILabel()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public methods
    public func setData(_ model: MainViewModel) {
        let calloriesToday = model.todayProducts.map { $0.nutrition.callories }.reduce(0, +)
        calloriesCountLabel.text = "\(calloriesToday)/\(model.dailyNutrition.callories)"
        rateCalloriesLabel.text = calloriesToday < model.dailyNutrition.callories ?  "👍" : "👎"
    }

    // MARK: - Private methods
    private func setup() {
        configureCardView()
        configureCalloriesLabel()
        configureCalloriesCountLabel()
        configureRateCalloriesLabel()
    }

    private func configureRateCalloriesLabel() {
        cardView.addSubview(rateCalloriesLabel)

        rateCalloriesLabel.font = .systemFont(ofSize: 18, weight: .light)
        rateCalloriesLabel.textColor = .white

        rateCalloriesLabel.snp.makeConstraints { make in
            make.top.equalTo(calloriesCountLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func configureCalloriesCountLabel() {
        cardView.addSubview(calloriesCountLabel)

        calloriesCountLabel.font = .systemFont(ofSize: 22, weight: .heavy)
        calloriesCountLabel.textColor = .white

        calloriesCountLabel.snp.makeConstraints { make in
            make.top.equalTo(calloriesLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func configureCalloriesLabel() {
        cardView.addSubview(calloriesLabel)

        calloriesLabel.text = R.string.mainScreenLocale.mainDayliCallories()
        calloriesLabel.font = .systemFont(ofSize: 21)
        calloriesLabel.textColor = .white

        calloriesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
    }

    private func configureCardView() {
        contentView.addSubview(cardView)
        cardView.backgroundColor = UIColor(hex: "#61B0B7", alpha: 1)
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowColor = UIColor(hex: "#61B0B7", alpha: 1).cgColor
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 3

        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(9)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(120)
            make.bottom.equalToSuperview().offset(-25)
        }
    }
}
