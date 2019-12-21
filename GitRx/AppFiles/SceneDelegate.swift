//
//  SceneDelegate.swift
//  GitRx
//
//  Created by Михаил Нечаев on 21.12.2019.
//  Copyright © 2019 Михаил Нечаев. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootVC = ReposListViewController()
            let navigationVC = UINavigationController(rootViewController: rootVC)
            window.rootViewController = navigationVC
            self.window = window
            window.makeKeyAndVisible()
        }
    }

}

