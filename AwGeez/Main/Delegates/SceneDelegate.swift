//
//  SceneDelegate.swift
//  AwGeez
//
//  Created by Tony Dэ on 29.12.2022.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var router: WindowsRouter!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // prevents following UI launch
        if ProcessInfo.processInfo.isTestRun {
            print("Test run: scene willConnectTo session is returned")
            return
        }

        guard let windowScene = (scene as? UIWindowScene) else { return }
        router = WindowsRouter(windowScene: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
}
