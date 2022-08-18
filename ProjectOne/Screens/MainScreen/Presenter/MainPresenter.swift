//
//  MainPresenter.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    
}

protocol MainPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol)
    func getUserNutrionInfo() -> [String: String]?
    func goToProfileSettings()
    func getProducts() -> [Product]?
    func goToAddProduct()
    func getDayliNutrion() -> [String: String]?
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var router: RouterProtocol
    let dataManager: DataStoreManagerProtocol!
    
    required init(view: MainViewProtocol, router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol) {
        self.view = view
        self.router = router
        self.dataManager = dataStorageManager
        
    }
    
    func getProducts() -> [Product]? {
        let products = dataManager.getProduct()
        return products
    }
    
    func getUserNutrionInfo() -> [String: String]? {
        let userInfo = dataManager.getUser()?.last
        guard let userName = userInfo?.name else { return nil }
        guard let birthday = userInfo?.birthday else { return nil }
        guard let physicalState = userInfo?.physicalState else { return nil }
        guard let isMale = userInfo?.isMale else { return nil }
        guard let height = userInfo?.height else { return nil }
        guard let weight = userInfo?.weight else { return nil }
        
        let calloriesFormula = calloriesFormula(isMale: isMale, weight: Int(weight), height: Int(height), birthday: birthday)
        
        let calloriesFormulaWithTrain = calloriesFormulaWightTrain(baseCalories: calloriesFormula, physicalState: Int(physicalState))
        
        let proteinFormula = calloriesFormulaWithTrain * 0.3 / 4
        let fatsFormula = calloriesFormulaWithTrain * 0.3 / 9
        let carbsFormula = calloriesFormulaWithTrain * 0.4 / 4
        
        let callories = Int(round(calloriesFormulaWithTrain))
        let carbs = Int(round(carbsFormula))
        let protein = Int(round(proteinFormula))
        let fats = Int(round(fatsFormula))
        
        let nutrionInfo = ["callories": String(callories), "fats": String(fats), "carbs": String(carbs), "protein": String(protein),
                           "userName": userName]
        return nutrionInfo
    }
    
    func getDayliNutrion() -> [String: String]? {
        let dayliNutrion = dataManager.getDayliNutrion()?.last
        let callories = Int(dayliNutrion?.callories ?? 0)
        let carbs = Int(dayliNutrion?.carbs ?? 0)
        let protein = Int(dayliNutrion?.protein ?? 0)
        let fats = Int(dayliNutrion?.fats ?? 0)
        
        let dayliNutrionData = ["callories": String(callories), "carbs": String(carbs), "protein": String(protein), "fats": String(fats) ]
        return dayliNutrionData
    }
    
    func goToProfileSettings() {
        router.showInfoProfileSetting(isShowAfterOnbording: false)
    }
    
    func goToAddProduct() {
        router.initAddProductScreen()
    }
}

extension MainPresenter {
    
    private func calloriesFormulaWightTrain(baseCalories: Double, physicalState: Int ) -> Double {
        switch physicalState {
        case 1:
            return baseCalories * 1.2
            
        case 2:
            return baseCalories * 1.375
            
        case 3:
            return baseCalories * 1.55
            
        case 4:
            return baseCalories * 1.725
            
        case 5:
            return baseCalories * 1.9
            
        default:
            return 0
        }
    }
    
    private func calloriesFormula(isMale: Bool, weight: Int, height: Int, birthday: String) -> Double {
        let age = calcAge(birthday: birthday)
        let a = 10 * weight
        let b = Double(height) * 6.25
        let c = 5 * age
        
        if isMale {
            return (Double(a)) + (Double(b)) - (Double(c)) + 5
        } else {
            return (Double(a)) + (Double(b)) - (Double(c)) - 161
        }
    }
    
    private func calcAge(birthday: String) -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
}
