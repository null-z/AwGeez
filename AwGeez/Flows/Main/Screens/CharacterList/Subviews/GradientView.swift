//
//  GradientView.swift
//  AwGeez
//
//  Created by Tony Dэ on 16.05.2023.
//

import UIKit

class GradientView: View {
    
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }
    
    var colors: [UIColor]? {
        didSet {
            guard let gradientLayer = layer as? CAGradientLayer else { return }
            guard let colors else {
                gradientLayer.colors = [UIColor.clear.cgColor]
                return
            }
            gradientLayer.colors = colors.map { $0.cgColor }
        }
    }
}
