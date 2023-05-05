//
//  WindowsRouter.swift
//  AwGeez
//
//  Created by Tony Dэ on 29.04.2023.
//

import UIKit

final class WindowsRouter {
    
    private let windowScene: UIWindowScene
    
    private var splashFlowRouter: SplashFlowRouter?
    private var mainFlowRouter: MainFlowRouter
    
    init(windowScene: UIWindowScene) {
        self.windowScene = windowScene
        self.splashFlowRouter = SplashFlowRouter(window: UIWindow(windowScene: windowScene))
        self.mainFlowRouter = MainFlowRouter(window: UIWindow(windowScene: windowScene))
        
        splashFlowRouter?.delegate = self
        showSplashFlow()
    }
    
    private func showSplashFlow() {
        splashFlowRouter?.window.windowLevel = .normal + 1
        splashFlowRouter?.window.makeKeyAndVisible()
    }
    
    private func showMainFlow() {
        mainFlowRouter.showRoot()
        mainFlowRouter.window.makeKeyAndVisible()
    }
}

protocol FlowRouterDelegate: AnyObject {
    func flowWillFinish()
    func flowDidFinish()
}

extension WindowsRouter: FlowRouterDelegate {
    
    func flowWillFinish() {
        mainFlowRouter.window.windowLevel = .normal
        mainFlowRouter.window.isHidden = false
        mainFlowRouter.showRoot()
    }
    
    func flowDidFinish() {
        mainFlowRouter.window.makeKey()
        mainFlowRouter.showStatusBar()
        splashFlowRouter = nil
    }
}
