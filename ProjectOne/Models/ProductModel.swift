//
//  ProductModel.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation

struct ProductModel: Codable {
    var productName: String
    var productDate: Date
    var note: String
    var nutrition: NutritionModel

    init(
        productName: String = "",
        note: String = "",
        productDate: Date = Date(),
        nutrition: NutritionModel = NutritionModel()
    ) {
        self.productName = productName
        self.note = note
        self.nutrition = nutrition
        self.productDate = productDate
    }

    init(_ model: ProductCoreData) {
        self.productName = model.name ?? ""
        self.note = model.note ?? ""
        self.productDate = model.date ?? Date()
        self.nutrition = NutritionModel(model.nutritionCoreData ?? NutritionCoreData())
    }
}
