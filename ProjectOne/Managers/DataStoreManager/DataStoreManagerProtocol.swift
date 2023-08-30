//
//  DataStoreManagerProtocol.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation

protocol DataStoreManagerProtocol {
    func setUser(_ model: UserModel)
    func getUser() -> [UserCoreData]?
    func getProduct() -> [ProductCoreData]?
    func addProduct(_ model: ProductModel)
}
