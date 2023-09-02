//
//  SceneDelegate.swift
//  movies_uikit
//
//  Created by Ademola Fadumo on 08/08/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        print("Here is tmdb api key \(Environment.tmdbApiKey)")

        // Set root view controller to be main tab bar controller
        let tabBarController = MainTabBarViewController()

        // set main window root view controller to main tab bar controller
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController

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
            if context.url.scheme == "movies-uikit" && context.url.absoluteString.localizedCaseInsensitiveContains("authenticate") {
                (UIApplication.shared.delegate as? AppDelegate)?.repositoryProvider.authRepository.getSessionId { success in
                    if success {
                        navigationController.pushViewController(Routes.home.vc, animated: true)
                    }
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}
