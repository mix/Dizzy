//
//  DizzyActivityIndicatorView.swift
//  DizzySample
//
//  Created by Robert Otani on 7/9/16.
//  Copyright © 2016 Robert Otani. All rights reserved.
//

import UIKit
import QuartzCore

class DizzyActivityIndicatorView: UIView {
    private static let _animationLayerName = "DizzyActivityIndicatorView_animationLayer"
    private let _animationLayer: CALayer!
    
    @IBInspectable var image: UIImage = UIImage() {
        didSet {
            _configureAnimationLayer()
        }
    }
    @IBInspectable var isAnimating: Bool = false
    @IBInspectable var hidesWhenStopped: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        _animationLayer = CALayer()
        _animationLayer.name = self.dynamicType._animationLayerName
        super.init(coder: aDecoder)
        
        _stop()
    }
    
    private func _configureAnimationLayer() {
        if let _ = layer.sublayers?.filter({ return $0.name == self.dynamicType._animationLayerName }) {
            return
        }
        _animationLayer.contents = image.CGImage
        _animationLayer.masksToBounds = true
        _animationLayer.frame = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotation.duration = 1.0
        rotation.removedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = kCAFillModeForwards
        rotation.fromValue = NSNumber(double: 0.0)
        rotation.toValue = NSNumber(double: 2.0 * M_PI)
        _animationLayer.addAnimation(rotation, forKey: "rotate")
        layer.addSublayer(_animationLayer)
    }
    
    private func _stop() {
        isAnimating = false

        let timeOffset = _animationLayer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        _animationLayer.speed = 0.0
        _animationLayer.timeOffset = timeOffset
        
        if hidesWhenStopped {
            hidden = true
        }
    }
    
    private func _go() {
        isAnimating = true
        
        let timeOffset : CFTimeInterval = _animationLayer.timeOffset
        
        _animationLayer.speed = 1.0
        _animationLayer.timeOffset = 0.0
        _animationLayer.beginTime = 0.0
        
        let timeSinceOffset = _animationLayer.convertTime(CACurrentMediaTime(), fromLayer: nil) - timeOffset
        _animationLayer.beginTime = timeSinceOffset
        
    }
    
    func stopAnimating() {
        guard isAnimating else {
            return
        }
        _stop()
    }
    
    func startAnimating() {
        if isAnimating {
            return
        }
        if hidden {
            hidden = false
        }
        _go()
    }
}
