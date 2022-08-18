//
//  AddProductViewController.swift
//  ProjectOne
//
//  Created by Timur Israilov on 11/10/21.
//

import UIKit

class AddProductViewController: UIViewController {
    // MARK: - UIElemets
    private let mainView = UIView()
    private let mainLabel = UILabel()
    private let fatsTextField = UITextField()
    private let carbsTextField = UITextField()
    private let proteinTextField = UITextField()
    private let calloriesTextField = UITextField()
    private let productNameTextField = UITextField()
    private let addButton = BaseButton()
    
    // MARK: - Dependences
    var presenter: AddProductPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewDidAppearSetup()
    }
    // MARK: - Private
    
    private func viewDidLoadSetup() {
        view.backgroundColor = .white
        configureStandartNavBar()
        configureMainView()
        configureAddButton()
        configureHiddenKeyboard()
    }
    
    private func configureHiddenKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAction))
        view.addGestureRecognizer(tap)
    }

    
    private func viewDidAppearSetup() {
        configureMainLabel()
        configureFatsTextField()
        configureProteinTextField()
        configureCarbsTextField()
        configureCalloriesTextField()
        configureProductNameTextField()
        
        let topColor = UIColor(hex: "#0583D2", alpha: 1)
        let bottomColor = UIColor(hex: "#61B0B7", alpha: 1)
        mainView.configureCardViewGradient(colorTop: topColor, colorBottom: bottomColor)
        addButton.configureCardViewGradient(colorTop: bottomColor, colorBottom: topColor)
        addButton.setTitle(R.string.locale.addProductAddButton(), for: .normal)
    }
    
    private func configureAddButton() {
        view.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(100)
            make.width.equalToSuperview().inset(30)
            make.left.equalTo(30)
            make.height.equalTo(50)
        }
    }
    
    private func configureProductNameTextField() {
        mainView.addSubview(productNameTextField)
        
        productNameTextField.backgroundColor = .clear
        productNameTextField.layer.cornerRadius = 5
        productNameTextField.placeholder = R.string.locale.addProductName()
        productNameTextField.textAlignment = .center
        productNameTextField.textColor = .white
        
        productNameTextField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
    }
    
    private func configureCalloriesTextField() {
        mainView.addSubview(calloriesTextField)
        
        calloriesTextField.backgroundColor = .clear
        calloriesTextField.layer.cornerRadius = 5
        calloriesTextField.placeholder = R.string.locale.addProductDishCallories()
        calloriesTextField.textAlignment = .center
        calloriesTextField.textColor = .white
        calloriesTextField.keyboardType = .numberPad
        calloriesTextField.delegate = self
        
        calloriesTextField.snp.makeConstraints { make in
            make.top.equalTo(fatsTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
    }
    
    private func configureMainView() {
        view.addSubview(mainView)
        
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowColor = UIColor(hex: "#0583D2", alpha: 1).cgColor
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 3
        
        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0)
            make.right.equalTo(-16)
            make.left.equalTo(16)
            make.height.equalTo(200)
        }
        
    }
    
    private func configureMainLabel() {
        mainView.addSubview(mainLabel)
        
        mainLabel.text = R.string.locale.addProductTitle()
        mainLabel.textColor = .white
        mainLabel.font = .systemFont(ofSize: 20)
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureFatsTextField() {
        mainView.addSubview(fatsTextField)
        
        fatsTextField.backgroundColor = .clear
        fatsTextField.placeholder = R.string.locale.unitFats()
        fatsTextField.textAlignment = .center
        fatsTextField.layer.cornerRadius = 5
        fatsTextField.textColor = .white
        fatsTextField.keyboardType = .numberPad
        fatsTextField.delegate = self
        
        fatsTextField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
        }
    }
    
    private func configureProteinTextField() {
        mainView.addSubview(proteinTextField)
        
        proteinTextField.backgroundColor = .clear
        proteinTextField.placeholder = R.string.locale.unitProtein()
        proteinTextField.textAlignment = .center
        proteinTextField.layer.cornerRadius = 5
        proteinTextField.textColor = .white
        proteinTextField.keyboardType = .numberPad
        proteinTextField.delegate = self
        
        proteinTextField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(50)
            make.left.equalTo(fatsTextField.snp.right).offset(16)
            make.width.equalTo(100)
        }
    }
    
    private func configureCarbsTextField() {
        mainView.addSubview(carbsTextField)
        
        carbsTextField.backgroundColor = .clear
        carbsTextField.layer.cornerRadius = 5
        carbsTextField.placeholder = R.string.locale.unitCarbs()
        carbsTextField.textAlignment = .center
        carbsTextField.textColor = .white
        carbsTextField.keyboardType = .numberPad
        carbsTextField.delegate = self
        
        carbsTextField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(50)
            make.right.equalTo(fatsTextField.snp.left).offset(-16)
            make.width.equalTo(100)
        }
    }
}

private extension AddProductViewController {
    // MARK: - Actions
    @objc func addButtonAction() {
        let callories = calloriesTextField.text?.removeCharacters(from: CharacterSet.decimalDigits.inverted) ?? ""
        let fats = fatsTextField.text?.removeCharacters(from: CharacterSet.decimalDigits.inverted) ?? ""
        let carbs = carbsTextField.text?.removeCharacters(from: CharacterSet.decimalDigits.inverted) ?? ""
        let protein = proteinTextField.text?.removeCharacters(from: CharacterSet.decimalDigits.inverted) ?? ""
        let productName = productNameTextField.text ?? ""
        presenter.addProduct(productName: productName, callories: Int(callories)!, fats: Int(fats)!, carbs: Int(carbs)!, protein: Int(protein)!)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboardAction() {
        view.endEditing(true)
    }
}

extension AddProductViewController: AddProductViewProtocol {
    
}

extension AddProductViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        var unitString: String {
            if textField.placeholder == R.string.locale.addProductDishCallories() {
                return R.string.locale.unitCallories()
            } else {
                return R.string.locale.unitWeightGr()
            }
        }
        let newLength = textField.text!.count + string.count - range.length
        
        if textField.placeholder == R.string.locale.addProductDishCallories() {
            if string == "" {
                // handle backspace scenario here
                return true
            } else if var textString = textField.text {
                if textString.contains(unitString) && newLength <= 9 {
                    textString = textString.replacingOccurrences(of: unitString, with: "")
                    textString += string + unitString
                    textField.text = textString
                } else if newLength <= 9 {
                    textField.text = string + unitString
                }
                return false
            }
            
        } else {
            
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
            
        }
        return false
    }
    
}
