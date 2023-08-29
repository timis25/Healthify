//
//  NutritionModel.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation

struct NutritionModel: Codable {
    var fats: Int
    var carbs: Int
    var proteins: Int
    var callories: Int

    init(fats: Int = 0, carbs: Int = 0, proteins: Int = 0, callories: Int = 0) {
        self.fats = fats
        self.carbs = carbs
        self.proteins = proteins
        self.callories = callories
    }

    init(_ model: NutritionCoreData) {
        self.fats = Int(model.fats)
        self.carbs = Int(model.carbs)
        self.callories = Int(model.callories)
        self.proteins = Int(model.protein)
    }
}
