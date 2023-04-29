//
//  SplashScreenViewController.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.03.2023.
//

import UIKit
import SnapKit

final class SplashScreenView: ViewController {
    
    private let presenter: SplashScreenViewOutput
    
    private let logo = UIImageView(image: R.image.logo())
    private let loadingView = LoadingView()
    private let maskLayer = HoledMaskLayer()
    private let reloadButton = UIButton()
    private let errorMessageLabel = UILabel()
    
    init(presenter: SplashScreenViewOutput) {
        self.presenter = presenter
        super.init()
    }
    
    private var logoInitialYConstraint: Constraint?
    private var loadingViewInitialYConstraint: Constraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        presenter.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maskLayer.frame = view.bounds
        maskLayer.holeCenter = loadingView.center
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    @objc
    func reloadButtonTapped() {
        presenter.reloadButtonDidTapped()
    }
}

// MARK: Make UI
extension SplashScreenView {
    private func makeUI() {
        view.addSubview(logo)
        view.addSubview(loadingView)
        view.addSubview(reloadButton)
        view.addSubview(errorMessageLabel)
        
        view.backgroundColor = R.color.background()
        
        makeErrorLabel()
        makeReloadButton()
        makeMaskLayer()
        
        setupLayout()
    }
    
    private func makeErrorLabel() {
        errorMessageLabel.numberOfLines = 2
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.font = UIFont.italicSystemFont(ofSize: 16)
        errorMessageLabel.textColor = R.color.portal()
    }
    
    private func makeReloadButton() {
        reloadButton.isHidden = true
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .large)
        let image = UIImage(systemName: "arrow.clockwise.circle.fill", withConfiguration: config)
        reloadButton.setImage(image, for: .normal)
        reloadButton.tintColor = R.color.portal()
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    private func makeMaskLayer() {
        maskLayer.holeDiameter = 0
        maskLayer.setNeedsDisplay()
        view.layer.mask = maskLayer
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
        reloadButton.snp.makeConstraints { make in
            make.center.equalTo(loadingView)
        }
        errorMessageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(reloadButton.snp.bottom).offset(20)
        }
    }
}

// MARK: ViewInput
extension SplashScreenView: SplashScreenViewInput {
    func startLoadingAnimation() {
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    func stopLoadingAnimation() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
    
    func showReloadButton() {
        reloadButton.isHidden = false
    }
    
    func hideReloadButton() {
        reloadButton.isHidden = true
    }
    
    func showError(_ message: String) {
        errorMessageLabel.text = message
    }
    
    func startFinishAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.logo.snp.makeConstraints { make in
                self.logoInitialYConstraint?.deactivate()
                self.loadingViewInitialYConstraint?.deactivate()
                make.bottom.equalTo(self.loadingView.snp.top).offset(-40)
            }
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
                self.view.layoutIfNeeded()
                self.logo.alpha = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                let scale = (self.view.frame.size.height / self.loadingView.frame.size.height) * 2
                UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn]) {
                    self.loadingView.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
                self.startMasking()
            })
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
        wideAnimation.delegate = self
        maskLayer.add(wideAnimation, forKey: "wide")
    }
}

// MARK: CAAnimationDelegate
extension SplashScreenView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        presenter.finishAnimationDidEnd()
    }
}
