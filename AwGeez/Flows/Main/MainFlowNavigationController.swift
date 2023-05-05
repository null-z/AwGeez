//
//  MainFlowNavigationController.swift
//  AwGeez
//
//  Created by Tony Dэ on 05.05.2023.
//

import UIKit

class MainFlowNavigationController: UINavigationController {
    
    func showStatusBar() {
        // without async animation don't work
        DispatchQueue.main.async {
            self.hideStatusBar = false
            UIView.animate(withDuration: 0.3, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
        }
    }
    
    private var hideStatusBar = true
    
    override var prefersStatusBarHidden: Bool {
        hideStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        .slide
    }
    
    override var childForStatusBarHidden: UIViewController? {
        nil
    }
}
