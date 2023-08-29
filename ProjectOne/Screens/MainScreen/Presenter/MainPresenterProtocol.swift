//
//  MainPresenterProtocol.swift
//  ProjectOne
//
//  Created by Timur Israilov on 28/08/23.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    func goToProfileSettings()
    func goToAddProduct()
    func getModel() -> MainViewModel
}
