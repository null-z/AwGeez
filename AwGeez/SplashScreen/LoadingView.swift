//
//  LoadingView.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.03.2023.
//

import UIKit

final class LoadingView: View {
    
    enum State {
        case started
        case paused
        case stopped
    }
    
    private(set) var state: State = .stopped
    
    private let initialWidth = 40
    private let initialScale = CATransform3DMakeScale(0, 0, 1)
    
    private let rotationDuration = 1.0
    private let scalingDuration = 0.15
    
    private var rotatingLayer = CALayer()
    
    override init() {
        super.init()
        layer.addSublayer(rotatingLayer)
        rotatingLayer.contents = R.image.portal()?.cgImage
        layer.transform = initialScale
        addRotationAnimation()
    }
    
    override func layoutSublayers(of layer: CALayer) {
        rotatingLayer.frame = layer.bounds
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: initialWidth, height: initialWidth)
    }
    
    private func addRotationAnimation() {
        rotatingLayer.pauseAnimation()
        let rotationKeyPath = "transform.rotation.z"
        let rotationAnimation = CABasicAnimation(keyPath: rotationKeyPath)
        rotationAnimation.fromValue = rotatingLayer.value(forKeyPath: rotationKeyPath)
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = rotationDuration
        rotationAnimation.repeatCount = .infinity
        rotatingLayer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func startAnimating() {
        startRotationAnimation()
        if state == .stopped {
            startUpscaling()
        }
        state = .started
    }
    
    func pauseAnimating() {
        pauseRotationAnimation()
        state = .paused
    }
    
    func stopAnimating() {
        startRotationAnimation()
        if state != .stopped {
            startDownscaling()
        }
        state = .stopped
    }
    
    private func startRotationAnimation() {
        rotatingLayer.resumeAnimation()
    }
    
    private func pauseRotationAnimation() {
        rotatingLayer.pauseAnimation()
    }
    
    private func startUpscaling() {
        startScaleAnimation(1)
    }
    
    private func startDownscaling() {
        startScaleAnimation(0)
    }
    
    private func startScaleAnimation(_ toValue: Any) {
        let scaleKeyPath = "transform.scale"
        let animation = CABasicAnimation(keyPath: scaleKeyPath)
        animation.fromValue = layer.presentation()?.value(forKeyPath: scaleKeyPath) ?? layer.value(forKeyPath: scaleKeyPath)
        animation.toValue = toValue
        animation.duration = scalingDuration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        layer.add(animation, forKey: "scaleAnimation")
    }
}

extension LoadingView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let transform = layer.presentation()?.transform as? CATransform3D {
            layer.transform = transform
        }
        let isPaused = state == .paused
        let isFinishedStopAnimation = flag && state == .stopped
        if isPaused || isFinishedStopAnimation {
            pauseRotationAnimation()
        }
    }
}

fileprivate extension CALayer {
    
    func pauseAnimation() {
        if isPaused() == false {
            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }
    
    func resumeAnimation() {
        if isPaused() {
            let pausedTime = timeOffset
            speed = 1.0
            timeOffset = 0.0
            beginTime = 0.0
            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            beginTime = timeSincePause
        }
    }
    
    func isPaused() -> Bool {
        return speed == 0
    }
}
