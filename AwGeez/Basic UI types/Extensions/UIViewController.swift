//
//  UIViewController.swift
//  AwGeez
//
//  Created by Tony Dэ on 25.05.2023.
//

import UIKit

extension UIViewController {
    
    func replace(viewController: UIViewController, with otherViewController: UIViewController, animated: Bool) {
        if animated {
            let duration = 0.1
            UIView.animate(withDuration: duration) {
                viewController.view.alpha = 0
            } completion: { _ in
                self.remove(embeddedViewController: viewController)
                self.embed(viewController: otherViewController)
                UIView.animate(withDuration: duration) {
                    otherViewController.view.alpha = 1
                }
            }
        } else {
            self.remove(embeddedViewController: viewController)
            self.embed(viewController: otherViewController)
        }
    }
    
    func embed(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }
    
    func remove(embeddedViewController: UIViewController) {
        guard children.contains(embeddedViewController) else {
            return
        }
        
        embeddedViewController.willMove(toParent: nil)
        embeddedViewController.view.removeFromSuperview()
        embeddedViewController.removeFromParent()
    }
}
