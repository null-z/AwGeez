//
//  StretchyTableHeaderView.swift
//  AwGeez
//
//  Created by Tony Dэ on 11.05.2023.
//

import UIKit
import SnapKit

class StretchyTableHeaderView: View {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private var titleBackgroundView: UIView!
    
    private var imageViewTopConstraint: Constraint?
    
    override init() {
        super.init()
        makeUI()
    }
    
    func setImageUrl(_ imageUrl: URL) {
        imageView.setImage(with: imageUrl)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = min(scrollView.contentOffset.y, 0)
        imageViewTopConstraint?.update(offset: offset)
    }
}

// MARK: Make UI
extension StretchyTableHeaderView {
    
    private func makeUI() {
        addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFill
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textAlignment = .left
        titleLabel.adjustsFontSizeToFitWidth = true
        
        makeVisualEffects()
        
        setupLayout()
    }
    
    func makeVisualEffects() {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        imageView.addSubview(blurEffectView)
        titleBackgroundView = blurEffectView

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .label)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)

        vibrancyEffectView.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(vibrancyEffectView.layoutMarginsGuide)
        }

        blurEffectView.contentView.addSubview(vibrancyEffectView)
        vibrancyEffectView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupLayout() {
        imageView.snp.makeConstraints { make in
            imageViewTopConstraint = make.top.equalTo(self.snp.top).constraint
            make.left.bottom.right.equalToSuperview()
        }
                
        titleBackgroundView?.snp.makeConstraints({ make in
            make.left.bottom.right.equalToSuperview()
        })
    }
}
