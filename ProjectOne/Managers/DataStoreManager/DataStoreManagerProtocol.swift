//
//  DataStoreManagerProtocol.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation

protocol DataStoreManagerProtocol {
    func setUser(_ user: UserCoreData)
    func getUser() -> [UserCoreData]?
    func getProduct() -> [ProductCoreData]?
    func addProduct(_ model: ProductModel)
    func getDayliNutrion() -> [DayliNutrionCoreData]?
    func updateDayliNutrition(_ model: NutritionModel)
}
