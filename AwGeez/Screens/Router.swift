//
//  Router.swift
//  AwGeez
//
//  Created by Tony Dэ on 24.04.2023.
//

import UIKit

final class Router {
    
    private var windowScene: UIWindowScene
    
    private var splashWindow: UIWindow?
    private var mainWindow: UIWindow?
    
    init(windowScene: UIWindowScene) {
        self.windowScene = windowScene
        mainWindow = UIWindow(windowScene: windowScene)
        splashWindow = UIWindow(windowScene: windowScene)
        showSplashScreen()
    }
    
    func showSplashScreen() {
        splashWindow?.windowLevel = .statusBar + 1
        splashWindow?.backgroundColor = R.color.background()
        
        splashWindow?.rootViewController = SplashScreenAssembly().build(self)
        
        splashWindow?.makeKeyAndVisible()
    }
    
}

extension Router: SplashScreenRouter {
    func showRoot() {
        mainWindow?.rootViewController = ViewController()
        mainWindow?.windowLevel = .normal
        mainWindow?.isHidden = false
    }
    
    func removeSplashScreen() {
        mainWindow?.makeKey()
        splashWindow = nil
    }
}
