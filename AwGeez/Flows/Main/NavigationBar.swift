//
//  NavigationBar.swift
//  AwGeez
//
//  Created by Tony Dэ on 15.05.2023.
//

import UIKit

/// Supports transparent background color and restoration to initial color
class NavigationBar: UINavigationBar {
    
    private var initialShadowImage: UIImage?
    private var initialBackgroundImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialShadowImage = shadowImage
        initialBackgroundImage = backgroundImage(for: .default)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setItems(_ items: [UINavigationItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        items?.forEach({ item in
            removeBackButtonTitle(for: item)
        })
    }
    
    override func pushItem(_ item: UINavigationItem, animated: Bool) {
        super.pushItem(item, animated: animated)
        removeBackButtonTitle(for: item)
    }
    
    private func removeBackButtonTitle(for item: UINavigationItem) {
        item.backButtonTitle = ""
    }
}

// MARK: Color setting
extension NavigationBar {
    
    func resetColor() {
        shadowImage = initialShadowImage
        setBackgroundImage(initialBackgroundImage, for: .default)
    }
    
    func setBarColor(_ barColor: UIColor?) {
        guard let barColor,
              barColor.cgColor.alpha != 0 else {
            setBackgroundImage(UIImage(), for: .default)
            return
        }
        
        if barColor.cgColor.alpha >= 0.99 {
            resetColor()
        } else {
            setBackgroundImage(self.image(with: barColor), for: .default)
            shadowImage = UIImage()
        }
    }
    
    private func image(with color: UIColor) -> UIImage {
        let rect = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(1.0), height: CGFloat(1.0))
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
