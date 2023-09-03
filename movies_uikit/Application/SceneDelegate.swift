//
//  SceneDelegate.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 08/08/2023.
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

        // Set root view controller to be launch vc
        let initalVC = Routes.launch.vc

        // set main window root view controller to main tab bar controller
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: initalVC)

        //
        self.window = window
        window.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let navigationController = window?.rootViewController as?
                UINavigationController else {
            return
        }

        for context in URLContexts {
            if context.url.scheme == "movies-uikit" &&
                context.url.absoluteString
                .localizedCaseInsensitiveContains("authenticate") {

                (UIApplication.shared.delegate as? AppDelegate)?
                    .repositoryProvider
                    .authRepository
                    .getSessionId { success in
                    if success {
                        navigationController.pushViewController(Routes.mainTab.vc, animated: true)
                    }
                }
            }
        }
    }
}
