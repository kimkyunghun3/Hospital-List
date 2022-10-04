//
//  SceneDelegate.swift
//  Hospital-List
//
//  Created by Eddy on 2022/09/30.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let mainViewModel = MainViewModel(network: Network(), storage: PersistentManager.shared)
        let viewController = MainViewController(viewModel: mainViewModel)
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
