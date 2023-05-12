//
//  MainFlowNavigationController.swift
//  AwGeez
//
//  Created by Tony Dэ on 05.05.2023.
//

import UIKit

class MainFlowNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        viewControllers = [rootViewController]
        navigationBar.tintColor = R.color.portal()
        navigationBar.prefersLargeTitles = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
