//
//  HoledMaskLayer.swift
//  AwGeez
//
//  Created by Tony Dэ on 20.03.2023.
//

import UIKit

final class HoledMaskLayer: CALayer {
    
    @objc dynamic var holeDiameter: CGFloat = 0
    @objc dynamic var holeCenter: CGPoint = .zero
    
    private var gradient: CGGradient?
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        if let layer = layer as? HoledMaskLayer {
            self.holeCenter = layer.holeCenter
            self.holeDiameter = layer.holeDiameter
        } else {
            fatalError()
        }
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        let holeRadius = holeDiameter / 2
        let holeRect = CGRect(x: holeCenter.x - holeRadius,
                              y: holeCenter.y - holeRadius,
                              width: holeDiameter,
                              height: holeDiameter)
        
        ctx.beginPath()
        ctx.addRect(frame)
        ctx.addEllipse(in: holeRect)
        ctx.closePath()
        ctx.drawPath(using: .eoFillStroke)
        
        drawRadialGradient(in: ctx, holeRadius: holeRadius)
        
        super.draw(in: ctx)
    }
    
    private func drawRadialGradient(in ctx: CGContext, holeRadius: CGFloat) {
        let gradient = gradient(for: ctx)
        ctx.drawRadialGradient(gradient,
                               startCenter: holeCenter,
                               startRadius: 0,
                               endCenter: holeCenter,
                               endRadius: holeRadius,
                               options: .drawsBeforeStartLocation)
    }
    
    private func gradient(for ctx: CGContext) -> CGGradient {
        if let gradient = self.gradient {
            return gradient
        } else {
            let colorSpace = ctx.colorSpace
            let transparentColor = CGColor(gray: 0, alpha: 0)
            let opaqueColor = CGColor(gray: 0, alpha: 1)
            let colorComponents = [transparentColor, transparentColor, opaqueColor] as CFArray
            let locations: [CGFloat] = [0.0, 0.5, 1.0]
            guard let newGradient = CGGradient.init(colorsSpace: colorSpace,
                                                    colors: colorComponents,
                                                    locations: locations) else {
                fatalError("Can't initialize gradient")
            }
            self.gradient = newGradient
            return newGradient
        }
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == #keyPath(HoledMaskLayer.holeDiameter) {
            return true
        }
        if key == #keyPath(HoledMaskLayer.holeCenter) {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
}
