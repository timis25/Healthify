//
//  AgeViewCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 19/09/21.
//

import UIKit

protocol AgeViewCellProtocol: AnyObject {
    func sendData(birthDate: String)
}

final class AgeViewCell: UITableViewCell {
    // MARK: - UI Elements
    private let ageTextField = UITextField()
    private let view = UIView()
    private let separator = UIView()
    private let mainLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let toolBar = UIToolbar()

    // MARK: - Public properties
    weak var delegate: AgeViewCellProtocol?

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureMainLabel()
        configureNameTextField()
        configureSeparator()
        configureDatePiker()
        configureToolBar()
        separator.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func configureToolBar() {
        let doneBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneBarAction)
        )

        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        let cancelButton = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(doneBarButtonAction)
        )

        toolBar.sizeToFit()
        toolBar.setItems([cancelButton, flexibleSpace, doneBarButtonItem], animated: true)
    }

    private func configureDatePiker() {
        ageTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        ageTextField.inputAccessoryView = toolBar
        datePicker.maximumDate = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
        }
    }

    private func configureMainLabel() {
        view.addSubview(mainLabel)

        mainLabel.text = R.string.profileInfoLocale.profileBirthday()
        mainLabel.textColor = .white
        mainLabel.font = .systemFont(ofSize: 20)
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
        }
    }

    private func configureSeparator() {
        view.addSubview(separator)

        separator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)

        separator.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.left.right.bottom.equalToSuperview()
        }
    }

    private func configureNameTextField() {
        view.addSubview(ageTextField)

        ageTextField.placeholder = R.string.profileInfoLocale.profileEnterBirthday()
        ageTextField.backgroundColor = UIColor(hex: "#90e0ef", alpha: 1)
        ageTextField.layer.cornerRadius = 5
        ageTextField.font = .systemFont(ofSize: 18)

        ageTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.top.equalTo(mainLabel.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(15)
        }
    }

    private func configureView() {
        contentView.addSubview(view)

        view.backgroundColor = UIColor(hex: "#0077b6", alpha: 1)

        view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-3)
            make.left.right.equalToSuperview().inset(25)
            make.bottom.equalToSuperview()
        }
    }

    // MARK: - Actions
    @objc private func doneBarAction() {
        let stringDate = datePicker.date.toDate()
        ageTextField.text = stringDate
        delegate?.sendData(birthDate: stringDate)
        view.endEditing(true)
    }

    @objc private func doneBarButtonAction() {
        view.endEditing(true)
    }
}
