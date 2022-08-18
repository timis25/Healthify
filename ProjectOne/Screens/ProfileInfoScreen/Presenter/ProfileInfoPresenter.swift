//
//  ProfileInfoPresenter.swift
//  ProjectOne
//
//  Created by Timur Israilov on 19/09/21.
//

import Foundation

protocol ProfileInfoViewProtocol: AnyObject {
    
}

protocol ProfileInfoPresenterProtocol: AnyObject {
    init(view: ProfileInfoViewProtocol, router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol)
    func setUser(name: String, birthDate: String, isMale: Bool, physicalState: Int, weight: Int, height: Int)
}

class ProfileInfoPresenter: ProfileInfoPresenterProtocol {
    
    weak var view: ProfileInfoViewProtocol?
    var router: RouterProtocol
    let dataManager: DataStoreManagerProtocol!
    
    required init(view: ProfileInfoViewProtocol, router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol) {
        self.view = view
        self.router = router
        self.dataManager = dataStorageManager
        
    }
    
    func setUser(name: String, birthDate: String, isMale: Bool, physicalState: Int, weight: Int, height: Int) {
        dataManager.setUser(name: name, birthDate: birthDate, isMale: isMale, physicalState: physicalState, weight: weight, height: height)
        router.initMainScreens()
        UserSettings.setIsShowStartProfileSettings(true)
        UserSettings.setNowDay(Date())
    }
}
