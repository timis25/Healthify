//
//  AdditionalInfoViewCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 20/09/21.
//

import UIKit
import CoreLocation

protocol AdditionalInfoViewCelDelegate: AnyObject {
    func textEditDidChange(_ text: String)
    func sendSex(isMale: Bool)
    func sendPhysicalState(data: PhysicalStateModel)
}

class AdditionalInfoViewCell: UITableViewCell {
    private let view = UIView()
    private let mainLabel = UILabel()
    private let physicalStateTextField = VerticalTextView()
    private var selectorSex = UISegmentedControl()
    private let physcPicker = UIPickerView()
    private var pickerData = [PhysicalStateModel]()
    private let toolBar = UIToolbar()
    var selectedType: PhysicalStateModel?
    weak var delegate: AdditionalInfoViewCelDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setPickerData()
        configureView()
        configureMainLabel()
        configureSelectorSex()
        configurePhysicalStateTextField()
        configurePhyscPicker()
        configureToolBar()
    }

    private func configureToolBar() {
        let doneBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneBarButtonAction)
        )
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.sizeToFit()
        toolBar.setItems([space, doneBarButtonItem], animated: true)
    }

    private func configureSelectorSex() {
        self.selectorSex = UISegmentedControl(items: [R.string.locales.profileMale(), R.string.locales.profileFemale()])
        view.addSubview(selectorSex)
        selectorSex.backgroundColor = UIColor(hex: "#90e0ef", alpha: 1)
        selectorSex.selectedSegmentIndex = 0
        selectorSex.layer.cornerRadius = 15
        delegate?.sendSex(isMale: true)
        selectorSex.addTarget(self, action: #selector(selectorSexAction), for: .valueChanged)
        selectorSex.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(20)
            make.left.equalTo(20)
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
        }
    }

    private func setPickerData() {
        pickerData.append(PhysicalStateModel(id: 1, description: R.string.locales.physxState1()))
        pickerData.append(PhysicalStateModel(id: 2, description: R.string.locales.physxState2()))
        pickerData.append(PhysicalStateModel(id: 3, description: R.string.locales.physxState3()))
        pickerData.append(PhysicalStateModel(id: 4, description: R.string.locales.physxState4()))
        pickerData.append(PhysicalStateModel(id: 5, description: R.string.locales.physxState5()))
    }

    private func configurePhyscPicker() {
        physcPicker.dataSource = self
        physcPicker.delegate = self
    }

    private func configureMainLabel() {
        view.addSubview(mainLabel)

        mainLabel.text = R.string.locales.profileAdditionalInfo()
        mainLabel.font = .systemFont(ofSize: 20)
        mainLabel.textColor = .white
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.centerX.equalToSuperview()
        }
    }

    private func configurePhysicalStateTextField() {
        view.addSubview(physicalStateTextField)

        physicalStateTextField.inputView = physcPicker
        physicalStateTextField.font = .systemFont(ofSize: 18)
        physicalStateTextField.backgroundColor = UIColor(hex: "#90e0ef", alpha: 1)
        physicalStateTextField.layer.cornerRadius = 10
        physicalStateTextField.isScrollEnabled = false
        physicalStateTextField.delegate = self
        physicalStateTextField.text = R.string.locales.profileEnterPhysxState()
        physicalStateTextField.textColor = .black
        physicalStateTextField.inputAccessoryView = toolBar

        physicalStateTextField.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.top.equalTo(selectorSex.snp.bottom).offset(10)
            make.width.equalToSuperview().inset(5)
            make.left.equalTo(5)
        }
    }

    private func configureView() {
        contentView.addSubview(view)

        view.backgroundColor = UIColor(hex: "#0077b6", alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview().inset(25)
            make.left.equalTo(25)
            make.bottom.equalToSuperview()
        }
    }

    @objc func doneBarButtonAction() {
        if let selectedType = selectedType {
            delegate?.sendPhysicalState(data: selectedType)
            view.endEditing(true)
        } else {
            physicalStateTextField.text = pickerData.first?.description

            delegate?.textEditDidChange(physicalStateTextField.text)
            delegate?.sendPhysicalState(data: pickerData.first!)
        }
    }

    @objc func selectorSexAction() {
        if selectorSex.selectedSegmentIndex == 0 {
            delegate?.sendSex(isMale: true)
        } else {
            delegate?.sendSex(isMale: false)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AdditionalInfoViewCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData.map({ $0.description })[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let text = pickerData.map({ $0.description })[row]
        physicalStateTextField.text = text
        selectedType = pickerData[row]
        delegate?.sendPhysicalState(data: selectedType!)
        delegate?.textEditDidChange(text)
    }
}

extension AdditionalInfoViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите свою физическую активность"
            textView.textColor = .lightGray
        }
    }
}
