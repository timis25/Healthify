//
//  WidgetModel.swift
//  ProjectOne
//
//  Created by Timur Israilov on 14/12/21.
//

import Foundation

struct WidgetModel: Codable {
    var todayProducts: [ProductModel]
    var dailyNutrition: NutritionModel
}
