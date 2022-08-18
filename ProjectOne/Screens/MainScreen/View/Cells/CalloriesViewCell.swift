//
//  CalloriesViewCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 16/09/21.
//

import UIKit

final class CalloriesViewCell: UITableViewCell {
    // MARK: - UIElemets
    private let cardView = UIView()
    private let calloriesLabel = UILabel()
    private let calloriesCountLabel = UILabel()
    private let rateCalloriesLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let colorTop = UIColor(hex: "#0583D2", alpha: 1)
        let colorBottom = UIColor(hex: "#61B0B7", alpha: 1)
        
        cardView.configureCardViewGradient(colorTop: colorBottom, colorBottom: colorTop)
    }
    // MARK: - Public
    public func setData(rateCallories: String, dayliCallories: String, nowCallories: String) {
        calloriesCountLabel.text = "\(nowCallories)/ \(dayliCallories)"
        rateCalloriesLabel.text = rateCallories
    }
    
    // MARK: - Private
    
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
        
        calloriesLabel.text = R.string.locale.mainDayliCallories()
        calloriesLabel.font = .systemFont(ofSize: 21)
        calloriesLabel.textColor = .white
        
        calloriesLabel.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureCardView() {
        contentView.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowColor = UIColor(hex: "#0583D2", alpha: 1).cgColor
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOpacity = 3
        
        cardView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(9)
            make.left.equalTo(9)
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(120)
            make.bottom.equalToSuperview().inset(25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
