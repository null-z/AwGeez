//
//  SplashFlowRouter.swift
//  AwGeez
//
//  Created by Tony Dэ on 29.04.2023.
//

import UIKit

final class SplashFlowRouter {
    
    weak var delegate: FlowRouterDelegate?
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        window.rootViewController = SplashScreenAssembly().build(self)
    }
}

extension SplashFlowRouter: SplashScreenRouter {
    
    func willDisappear() {
        delegate?.flowWillFinish()
    }
    
    func didDisappear() {
        delegate?.flowDidFinish()
    }
}
