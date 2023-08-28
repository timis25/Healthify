//
//  SceneDelegate.swift
//  ProjectOne
//
//  Created by Timur Israilov on 04/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        prepareWindow(windowScene: windowScene)
    }
}
