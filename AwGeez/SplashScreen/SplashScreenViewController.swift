//
//  SplashScreenViewController.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.03.2023.
//

import UIKit
import SnapKit

final class SplashScreenViewController: ViewController {
    
    typealias Block = () -> Void
    
    let block: Block?
    let animationBlock: Block?
    
    private let logo = UIImageView(image: R.image.logo())
    private let loadingView = LoadingView()
    private let maskLayer = HoledMaskLayer()
    
    init(with block: Block?, animationBlock: Block?) {
        self.block = block
        self.animationBlock = animationBlock
        super.init()
    }
    
    private var logoInitialYConstraint: Constraint?
    private var loadingViewInitialYConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.background()
        view.addSubview(logo)
        view.addSubview(loadingView)
        
        setupLayout()
        
        maskLayer.holeDiameter = 0
        maskLayer.setNeedsDisplay()
        view.layer.mask = maskLayer
        startLoading()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maskLayer.frame = view.bounds
        maskLayer.holeCenter = loadingView.center
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    private func setupLayout() {
        logo.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            logoInitialYConstraint = make.centerY.equalTo(view).constraint
            make.size.equalTo(view.snp.width).dividedBy(2)
        }
        loadingView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            loadingViewInitialYConstraint = make.top.equalTo(logo.snp.bottom).offset(40).priority(.high).constraint
            make.centerY.equalTo(view).priority(.medium)
        }
    }
    
    private func startLoading() {
        loadingView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.logo.snp.makeConstraints { make in
                self.logoInitialYConstraint?.deactivate()
                self.loadingViewInitialYConstraint?.deactivate()
                make.bottom.equalTo(self.loadingView.snp.top).offset(-40)
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
                self.view.layoutIfNeeded()
                self.logo.alpha = 0
            }
        })
        
        finishLoading()
    }
    
    private func finishLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5, execute: {
            let scale = (self.view.frame.size.height / self.loadingView.frame.size.height) * 2
            UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn]) {
                self.loadingView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
            self.startMasking()
        })
    }
    
    private func startMasking() {
        let wideAnimation = CABasicAnimation(keyPath: #keyPath(HoledMaskLayer.holeDiameter))
        wideAnimation.fromValue = maskLayer.holeDiameter
        wideAnimation.toValue = view.frame.height * 2
        wideAnimation.duration = 1
        wideAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        wideAnimation.fillMode = .forwards
        wideAnimation.isRemovedOnCompletion = false
        maskLayer.add(wideAnimation, forKey: "wide")
    }
}
