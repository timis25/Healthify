//
//  AddProductViewController.swift
//  ProjectOne
//
//  Created by Timur Israilov on 11/10/21.
//

import UIKit

protocol AddProductViewProtocol: AnyObject {
}

final class AddProductViewController: UIViewController {
    // MARK: - UI Elemets
    private let mainView = UIView()
    private let mainLabel = UILabel()
    private let fatsTextField = UITextField()
    private let carbsTextField = UITextField()
    private let proteinTextField = UITextField()
    private let calloriesTextField = UITextField()
    private let productNameTextField = UITextField()
    private let addButton = BaseButton()

    // MARK: - Private properties
    var presenter: AddProductPresenterProtocol

    // MARK: - Init
    init(presenter: AddProductPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override methids
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidLoadSetup()
    }

    // MARK: - Private methods
    private func viewDidLoadSetup() {
        view.backgroundColor = .white
        configureStandartNavBar()
        configureMainView()
        configureAddButton()
        configureHiddenKeyboard()
        configureMainLabel()
        configureFatsTextField()
        configureProteinTextField()
        configureCarbsTextField()
        configureCalloriesTextField()
        configureProductNameTextField()
    }

    private func configureHiddenKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardAction))
        view.addGestureRecognizer(tap)
    }

    private func configureAddButton() {
        view.addSubview(addButton)

        addButton.backgroundColor = UIColor(hex: "#61B0B7", alpha: 1)
        addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        addButton.setTitle(R.string.addProductLocale.addProductAddButton(), for: .normal)

        addButton.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.bottom).offset(100)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
    }

    private func configureProductNameTextField() {
        mainView.addSubview(productNameTextField)

        productNameTextField.backgroundColor = .clear
        productNameTextField.layer.cornerRadius = 5
        productNameTextField.placeholder = R.string.addProductLocale.addProductName()
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
        calloriesTextField.placeholder = R.string.addProductLocale.addProductDishCallories()
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

        mainView.backgroundColor = UIColor(hex: "#61B0B7", alpha: 1)
        mainView.layer.cornerRadius = 10
        mainView.layer.shadowOffset = .zero
        mainView.layer.shadowColor = UIColor(hex: "#61B0B7", alpha: 1).cgColor
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 3

        mainView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
    }

    private func configureMainLabel() {
        mainView.addSubview(mainLabel)

        mainLabel.text = R.string.addProductLocale.addProductTitle()
        mainLabel.textColor = .white
        mainLabel.font = .systemFont(ofSize: 20)

        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
    }

    private func configureFatsTextField() {
        mainView.addSubview(fatsTextField)

        fatsTextField.backgroundColor = .clear
        fatsTextField.placeholder = R.string.generalLocale.unitFats()
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
        proteinTextField.placeholder = R.string.generalLocale.unitProtein()
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
        carbsTextField.placeholder = R.string.generalLocale.unitCarbs()
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
    // MARK: - Actions
    @objc private func addButtonAction() {
        guard let calloriesText = calloriesTextField.text,
              let fatsText = fatsTextField.text,
              let carbsText = carbsTextField.text,
              let proteinText = proteinTextField.text else {
            return
        }

        let callories = Int(calloriesText.removeCharacters(from: CharacterSet.decimalDigits.inverted)) ?? 0
        let fats = Int(fatsText.removeCharacters(from: CharacterSet.decimalDigits.inverted)) ?? 0
        let carbs = Int(carbsText.removeCharacters(from: CharacterSet.decimalDigits.inverted)) ?? 0
        let proteins = Int(proteinText.removeCharacters(from: CharacterSet.decimalDigits.inverted)) ?? 0
        let productName = productNameTextField.text ?? ""

        var productModel = ProductModel()
        productModel.productName = productName
        productModel.nutrition = NutritionModel(fats: fats, carbs: carbs, proteins: proteins, callories: callories)

        presenter.addProduct(productModel)
    }

    @objc private func dismissKeyboardAction() {
        view.endEditing(true)
    }
}

// MARK: - AddProductViewProtocol
extension AddProductViewController: AddProductViewProtocol {
}

// MARK: - UITextFieldDelegate
extension AddProductViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        var unitString: String {
            return textField == calloriesTextField ?
            R.string.generalLocale.unitCallories() :
            R.string.generalLocale.unitWeightGr()
        }

        let newLength = textField.text!.count + string.count - range.length

        if string == "" {
            return true
        }

        if var textString = textField.text {
            let maxLength = textField == calloriesTextField ? 9 : 5

            if textString.contains(unitString) && newLength <= maxLength {
                textString = textString.replacingOccurrences(of: unitString, with: "")
                textString += string + unitString
                textField.text = textString
            } else if newLength <= maxLength {
                textField.text = string + unitString
            }

            return false
        }

        return false
    }
}
