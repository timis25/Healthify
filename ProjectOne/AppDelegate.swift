//
//  AppDelegate.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import UIKit
import CoreData

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        prepareWindow()
        return true
    }

    private func prepareWindow() {
        window = UIWindow()
        let navigationController = UINavigationController()
        let assembly = Assembly()
        let dataStoreManager = DataStoreManager()
        let router = Router(
            navigationController: navigationController,
            assembly: assembly,
            dataStorage: dataStoreManager,
            window: window!
        )

        if UserSettings.isShowStartProfileSettings() {
            router.initMainScreens()
        } else {
            router.showInfoProfileSetting(isShowAfterOnbording: true)
        }
        window?.makeKeyAndVisible()
    }
}
