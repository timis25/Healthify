//
//  MainPresenter.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import Foundation
import WidgetKit

final class MainPresenter: MainPresenterProtocol {
    // MARK: - Public properties
    weak var view: MainViewProtocol?

    // MARK: - Private properties
    private let router: RouterProtocol
    private let dataManager: DataStoreManagerProtocol

    // MARK: - Init
    init(router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol) {
        self.router = router
        self.dataManager = dataStorageManager
    }

    // MARK: - Public methods
    func getModel() -> MainViewModel {
        let dailyNutrition = getUserNutrionInfo()

        let widgetData = WidgetModel(todayProducts: [], dailyNutrition: dailyNutrition)
        UserSettings.addDataToWidget(widgetData)
        if #available(iOS 14.0, *) {
            WidgetCenter.shared.reloadAllTimelines()
        }
        return MainViewModel(
            dailyNutrition: dailyNutrition,
            todayProducts: getProducts(),
            user: getUser()
        )
    }

    func goToProfileSettings() {
        router.showInfoProfileSetting(isShowAfterOnbording: false)
    }

    func goToAddProduct() {
        router.initAddProductScreen()
    }

    // MARK: - Private methods
    private func getUserNutrionInfo() -> NutritionModel {
        var model = NutritionModel()
        let user = getUser()

        let totalCalories = calculateCalories(user)

        let calloriesFormulaWithTrain = calloriesFormulaWightTrain(
            baseCalories: totalCalories,
            physicalState: user.physicalState
        )

        let proteinFormula = calloriesFormulaWithTrain * 0.3 / 4
        let fatsFormula = calloriesFormulaWithTrain * 0.3 / 9
        let carbsFormula = calloriesFormulaWithTrain * 0.4 / 4

        let callories = Int(round(calloriesFormulaWithTrain))
        let carbs = Int(round(carbsFormula))
        let protein = Int(round(proteinFormula))
        let fats = Int(round(fatsFormula))

        model.callories = callories
        model.fats = fats
        model.proteins = protein
        model.carbs = carbs

        return model
    }

    private func getUser() -> UserModel {
        guard let userInfo = dataManager.getUser()?.last else { return UserModel() }
        return UserModel(userInfo)
    }

    private func getProducts() -> [ProductModel] {
        guard let products = dataManager.getProduct() else { return [] }
        return products.map({
            guard let name = $0.name,
                  let nutritionModel = $0.nutritionCoreData
            else { return ProductModel() }

            return ProductModel(productName: name, nutrition: NutritionModel(nutritionModel)) })
    }

    private func calloriesFormulaWightTrain(baseCalories: Double, physicalState: PhysicalState) -> Double {
        switch physicalState {
        case .noneActivity:
            return baseCalories * 1.2
        case .smallActivity:
            return baseCalories * 1.375
        case .mediumActivity:
            return baseCalories * 1.55
        case .fullWeekActivity:
            return baseCalories * 1.725
        case .hardTraining:
            return baseCalories * 1.9
        }
    }

    private func calculateCalories(_ user: UserModel) -> Double {
        let age = calcAge(birthday: user.birthday)
        let weightCalories = 10 * user.weight
        let heightCalories = Double(user.height) * 6.25
        let ageCalories = 5 * age

        let genderModifier = user.gender == .male ? 5 : -161

        return Double(weightCalories) + heightCalories - Double(ageCalories) + Double(genderModifier)
    }

    private func calcAge(birthday: Date) -> Int {
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthday, to: now, options: [])
        let age = calcAge.year
        return age!
    }
}
