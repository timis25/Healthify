//
//  NameViewCell.swift
//  ProjectOne
//
//  Created by Timur Israilov on 19/09/21.
//

import UIKit

protocol NameViewCellProtocol {
    func sendData(text: String, cellType: TextType)
}

class NameViewCell: UITableViewCell {
    private let view = UIView()
    private let nameTextField = UITextField()
    private let mainLabel = UILabel()
    private let separator = UIView()
    private let toolBar = UIToolbar()
    private var cellType: TextType?
    var delegate: NameViewCellProtocol?
    var unitString = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureMainLabel()
        configureNameTextField()
        configureSeparator()
        configureToolBar()
        separator.isHidden = true
    }
    
    public func setType(type: TextType) {
        cellType = type
        switch type {
        case .name:
            mainLabel.text = R.string.locale.profileName()
            nameTextField.placeholder = R.string.locale.profileEnterName()
            view.snp.remakeConstraints { make in
                make.top.equalTo(50)
                make.width.equalToSuperview().inset(25)
                make.left.equalTo(25)
                make.bottom.equalToSuperview()
            }
            
        case .weight:
            unitString = R.string.locale.unitWeight()
            mainLabel.text = R.string.locale.profileWeight()
            nameTextField.placeholder = R.string.locale.profileEnterWeight()
            view.layer.cornerRadius = 0
            nameTextField.keyboardType = .numberPad
            
        case .height:
            unitString = R.string.locale.unitHeight()
            mainLabel.text = R.string.locale.profileHeight()
            view.layer.cornerRadius = 0
            nameTextField.placeholder = R.string.locale.profileEnterHeight()
            nameTextField.keyboardType = .numberPad
        }
    }
    
    private func configureMainLabel() {
        view.addSubview(mainLabel)
        
        mainLabel.textColor = .white
        mainLabel.font = .systemFont(ofSize: 20)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureSeparator() {
        view.addSubview(separator)
        
        separator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.87)
        
        separator.snp.makeConstraints { make in
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    private func configureNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.backgroundColor = UIColor(hex: "#90e0ef", alpha: 1)
        nameTextField.layer.cornerRadius = 5
        nameTextField.font = .systemFont(ofSize: 18)
        nameTextField.returnKeyType = .done
        nameTextField.inputAccessoryView = toolBar
        nameTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        
        nameTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.top.equalTo(mainLabel.snp.bottom).offset(6)
            make.width.equalToSuperview().inset(15)
            make.left.equalTo(15)
        }
    }
    
    private func configureToolBar() {
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBarButtonAction))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.sizeToFit()
        toolBar.setItems([space, doneBarButtonItem], animated: true)
        
    }
    
    private func configureView() {
        contentView.addSubview(view)
        
        view.backgroundColor = UIColor(hex: "#0077b6", alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview().inset(25)
            make.left.equalTo(25)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func doneBarButtonAction() {
        view.endEditing(true)
    }
    
    @objc func textFieldDidChange() {
        delegate?.sendData(text: nameTextField.text ?? "", cellType: cellType!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NameViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if cellType == .height || cellType == .weight {
            
            let newLength = textField.text!.count + string.count - range.length
            
            if string == "" {
                // handle backspace scenario here
                return true
            } else if var textString = textField.text {
                if textString.contains(unitString) && newLength <= 5 {
                    textString = textString.replacingOccurrences(of: unitString, with: "")
                    textString += string + unitString
                    textField.text = textString
                } else if newLength <= 5 {
                    textField.text = string + unitString
                }
                return false
            }
            
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
