//
//  PUBorderedWipe.swift
//
//
//  Created by Ahmed Shendy on 11/11/21.
//

import UIKit

public final class PUBorderedWipe: UIView {
    
    // MARK: - Public API
    
    public var color: UIColor = UIColor(red: 66, green: 133, blue: 244, alpha: 1)
    public var duration: Double = 10
    
    public var onFinish: (() -> Void)?
    
    // MARK: - Properties
    
    private var borderLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    private var side: CGFloat {
        return bounds.width < bounds.height
            ? bounds.width
            : bounds.height
    }
    
    private var borderThickness: CGFloat {
        return side * 0.05
    }
    
    private var progressThickness: CGFloat {
        return (side / 2) - borderThickness
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        layer.addSublayer(borderLayer)
        layer.addSublayer(progressLayer)
        
        backgroundColor = UIColor.clear
    }
}

// MARK: - Build/Animate Layers

extension PUBorderedWipe {
    
    public override func layoutSubviews() {
        buildBorderLayer()
        buildProgressLayer()
        
        animateProgressLayer()
    }
    
    private func buildBorderLayer() {
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineWidth = borderThickness
        
        let radius = progressThickness + (borderThickness / 2)
        let path = buildCircularPath(radius: radius)
        
        borderLayer.path = path.cgPath
    }
    
    private func buildProgressLayer() {
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = color.cgColor
        progressLayer.lineWidth = progressThickness
        
        let radius = progressThickness / 2
        let path = buildCircularPath(radius: radius)
        
        progressLayer.path = path.cgPath
    }
    
    private func buildCircularPath(radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: CGPoint(x: bounds.midX, y: bounds.midY),
            radius: radius,
            startAngle: 270.toRadians(),
            endAngle: (270 - 360).toRadians(),
            clockwise: false
        )
        path.close()
        
        return path
    }
    
    private func animateProgressLayer() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.delegate = self
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        progressLayer.add(animation, forKey: animation.keyPath)
    }
}

// MARK: - CAAnimationDelegate

extension PUBorderedWipe: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        onFinish?()
    }
}
