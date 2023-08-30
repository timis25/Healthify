//
//  CardCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 09/09/21.
//

import UIKit

final class CardCell: UITableViewCell {
    // MARK: - UI Elemets
    private let cardView = UIView()
    private let proteinLabel = UILabel()
    private let fatsLabel = UILabel()
    private let carbsLabel = UILabel()
    private let proteinProgressView = UIProgressView()
    private let carbsProgressView = UIProgressView()
    private let fatsProgressView = UIProgressView()
    private let proteinCountLabel = UILabel()
    private let carbsCountLabel = UILabel()
    private let fatsCountLabel = UILabel()

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
        let dailyNutrition = model.dailyNutrition

        let carbsToday = model.todayProducts.map { $0.nutrition.carbs }.reduce(0, +)
        let fatsToday = model.todayProducts.map { $0.nutrition.fats }.reduce(0, +)
        let proteinsToday = model.todayProducts.map { $0.nutrition.proteins }.reduce(0, +)

        let carbsRatioText = "\(carbsToday)/\(dailyNutrition.carbs)"
        carbsCountLabel.text = "\(carbsRatioText)\(R.string.generalLocale.unitWeightGr())"

        fatsCountLabel.text = "\(fatsToday)/\(dailyNutrition.fats)\(R.string.generalLocale.unitWeightGr())"

        let proteinsRatioText = "\(proteinsToday)/\(dailyNutrition.proteins)"
        proteinCountLabel.text = "\(proteinsRatioText)\(R.string.generalLocale.unitWeightGr())"

        let nowProtein = Double(dailyNutrition.proteins)
        let dailyProteins = Double(proteinsToday)
        let proteinProgress = dailyProteins / nowProtein
        let nowFats = Double(dailyNutrition.fats)
        let dailyFats = Double(fatsToday)
        let fatsProgress = dailyFats / nowFats
        let nowCarbs = Double(dailyNutrition.carbs)
        let dailyCarbs = Double(carbsToday)
        let carbsProgress = dailyCarbs / nowCarbs

        fatsProgressView.progress = Float(fatsProgress)
        carbsProgressView.progress = Float(carbsProgress)
        proteinProgressView.progress = Float(proteinProgress)
    }

    // MARK: - Private methods

    private func setup() {
        configureCardView()
        configureFatsLabel()
        configureProteinLabel()
        configureCarbsLabel()
        configureProteinProgressView()
        configureFatsProgressView()
        configureCarbsProgressView()
        configureProteinCountLabel()
        configureCarbsCountLabel()
        configureFatsCountLabel()
    }

    private func configureCarbsCountLabel() {
        cardView.addSubview(carbsCountLabel)

        carbsCountLabel.numberOfLines = 0
        carbsCountLabel.textColor = .white
        carbsCountLabel.font = .systemFont(ofSize: 19, weight: .medium)
        carbsCountLabel.textAlignment = .center

        carbsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(carbsProgressView.snp.bottom).offset(15)
            make.centerX.equalTo(carbsLabel.snp.centerX)
            make.right.equalToSuperview().offset(-16)
        }
    }

    private func configureFatsCountLabel() {
        cardView.addSubview(fatsCountLabel)

        fatsCountLabel.textColor = .white
        fatsCountLabel.font = .systemFont(ofSize: 19, weight: .medium)
        fatsCountLabel.textAlignment = .center

        fatsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(fatsProgressView.snp.bottom).offset(15)
            make.centerX.equalTo(fatsLabel.snp.centerX)
        }
    }

    private func configureProteinCountLabel() {
        cardView.addSubview(proteinCountLabel)

        proteinCountLabel.textColor = .white
        proteinCountLabel.font = .systemFont(ofSize: 19, weight: .medium)
        proteinCountLabel.textAlignment = .center

        proteinCountLabel.snp.makeConstraints { make in
            make.top.equalTo(proteinProgressView.snp.bottom).offset(15)
            make.centerX.equalTo(proteinLabel.snp.centerX)
            make.left.equalToSuperview().offset(16)
        }
    }

    private func configureCarbsProgressView() {
        cardView.addSubview(carbsProgressView)

        carbsProgressView.progressTintColor = .blue
        carbsProgressView.backgroundColor = UIColor(red: 0.839, green: 0.851, blue: 0.894, alpha: 1)
        carbsProgressView.layer.cornerRadius = 4
        carbsProgressView.clipsToBounds = true

        carbsProgressView.snp.makeConstraints { make in
            make.top.equalTo(carbsLabel.snp.bottom).offset(15)
            make.centerX.equalTo(carbsLabel.snp.centerX)
            make.width.equalTo(110)
            make.height.equalTo(10)
        }
    }

    private func configureFatsProgressView() {
        cardView.addSubview(fatsProgressView)

        fatsProgressView.progressTintColor = .blue
        fatsProgressView.backgroundColor = UIColor(red: 0.839, green: 0.851, blue: 0.894, alpha: 1)
        fatsProgressView.layer.cornerRadius = 4
        fatsProgressView.clipsToBounds = true

        fatsProgressView.snp.makeConstraints { make in
            make.top.equalTo(fatsLabel.snp.bottom).offset(15)
            make.centerX.equalTo(fatsLabel.snp.centerX)
            make.width.equalTo(110)
            make.height.equalTo(10)
        }
    }

    private func configureProteinProgressView() {
        cardView.addSubview(proteinProgressView)

        proteinProgressView.progressTintColor = .blue
        proteinProgressView.backgroundColor = UIColor(red: 0.839, green: 0.851, blue: 0.894, alpha: 1)
        proteinProgressView.layer.cornerRadius = 4
        proteinProgressView.clipsToBounds = true

        proteinProgressView.snp.makeConstraints { make in
            make.top.equalTo(proteinLabel.snp.bottom).offset(15)
            make.centerX.equalTo(proteinLabel.snp.centerX)
            make.width.equalTo(110)
            make.height.equalTo(10)
        }
    }

    private func configureCarbsLabel() {
        cardView.addSubview(carbsLabel)

        carbsLabel.text = R.string.generalLocale.unitCarbs()
        carbsLabel.textColor = .white
        carbsLabel.textAlignment = .center

        carbsLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-80)
            make.width.greaterThanOrEqualTo(85)
            make.right.equalToSuperview().offset(-16)
        }
    }

    private func configureFatsLabel() {
        cardView.addSubview(fatsLabel)

        fatsLabel.text = R.string.generalLocale.unitFats()
        fatsLabel.textColor = .white
        fatsLabel.textAlignment = .center

        fatsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(85)
            make.centerX.equalToSuperview()
        }
    }

    private func configureProteinLabel() {
        cardView.addSubview(proteinLabel)

        proteinLabel.text = R.string.generalLocale.unitProtein()
        proteinLabel.textColor = .white
        proteinLabel.font = .systemFont(ofSize: 20)
        proteinLabel.textAlignment = .center

        proteinLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-80)
            make.width.greaterThanOrEqualTo(85)
            make.left.equalTo(16)
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
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(250)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
