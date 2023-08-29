//
//  ProfileInfoPresenter.swift
//  ProjectOne
//
//  Created by Timur Israilov on 19/09/21.
//

import Foundation

protocol ProfileInfoPresenterProtocol: AnyObject {
    func setUser(_ user: UserModel)
}

final class ProfileInfoPresenter: ProfileInfoPresenterProtocol {
    // MARK: - Public properties
    weak var view: ProfileInfoViewProtocol?
    // MARK: - Private  properties
    private let router: RouterProtocol
    private let dataManager: DataStoreManagerProtocol

    // MARK: - Init
    init(router: RouterProtocol, dataStorageManager: DataStoreManagerProtocol) {
        self.router = router
        self.dataManager = dataStorageManager
    }

    // MARK: - Public methods
    func setUser(_ user: UserModel) {
        dataManager.setUser(user)
        router.initMainScreens()
        UserSettings.setIsShowStartProfileSettings(true)
        UserSettings.setNowDay(Date())
    }
}
