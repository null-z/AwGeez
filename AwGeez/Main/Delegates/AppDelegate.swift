//
//  AppDelegate.swift
//  AwGeez
//
//  Created by Tony Dэ on 29.12.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // prevents following UI launch
        if ProcessInfo.processInfo.isTestRun {
            print("Test run: application didFinishLaunchingWithOptions is returned")
            return false
        }
        StartupConfigurator.default.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
