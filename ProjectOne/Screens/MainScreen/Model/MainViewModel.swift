//
//  MainViewModel.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation

struct MainViewModel {
    var dailyNutrition: NutritionModel = NutritionModel()
    var todayProducts: [ProductModel] = []
    var user: UserModel
}
