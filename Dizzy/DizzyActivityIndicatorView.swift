//
//  DizzyActivityIndicatorView.swift
//  DizzySample
//
//  Created by Robert Otani on 7/9/16.
//  Copyright © 2016 Robert Otani. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
public class DizzyActivityIndicatorView: UIView {
    private static let _animationLayerName = "DizzyActivityIndicatorView_animationLayer"
    private let _animationLayer: CALayer!
    private var _isAnimating: Bool = false
    private var _revolutionsPerSecond: UInt = 1
    private var _color: UIColor = UIColor.clearColor()
    
    @IBInspectable public var image: UIImage = UIImage() {
        didSet {
            _configureAnimationLayerFrame()
        }
    }
    @IBInspectable public var isAnimating: Bool {
        get {
            return _isAnimating
        }
        set {
            _isAnimating = newValue
            if newValue {
                _start()
            } else {
                _stop()
            }
        }
    }
    
    @IBInspectable public var hidesWhenStopped: Bool = false
    
    /// Resets to 1 if set to 0
    @IBInspectable public var revolutionsPerSecond: UInt {
        get {
            return _revolutionsPerSecond
        }
        set {
            _revolutionsPerSecond = newValue == 0 ? 1 : newValue
            _configureAnimationLayerRotation()
        }
    }
    
    @IBInspectable public var color: UIColor {
        get {
            return _color
        }
        set {
            _color = newValue
            image = _colorizedImage(image)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        _animationLayer = CALayer()
        _animationLayer.name = self.dynamicType._animationLayerName
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        _animationLayer = CALayer()
        _animationLayer.name = self.dynamicType._animationLayerName
        super.init(frame: frame)
    }
    
    private func _colorizedImage(image: UIImage) -> UIImage {
        if color == UIColor.clearColor() {
            return image
        }
        
        // Thanks to @fabb for this gist: https://gist.github.com/fabb/007d30ba0759de9be8a3
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let context: CGContext! = UIGraphicsGetCurrentContext()
        assert(context != nil)
        
        CGContextTranslateCTM(context, 0, image.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        let rect = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        
        CGContextSetBlendMode(context, .Normal)
        color.setFill()
        CGContextFillRect(context, rect)
        
        CGContextSetBlendMode(context, .DestinationIn)
        CGContextDrawImage(context, rect, image.CGImage)
        
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return colorizedImage
    }
    
    private func _configureAnimationLayerFrame() {
        _animationLayer.contents = image.CGImage
        _animationLayer.masksToBounds = true
        _animationLayer.frame = CGRect(x: 0.0, y: 0.0, width: image.size.width, height: image.size.height)
        if let _ = layer.sublayers?.filter({ return $0.name == self.dynamicType._animationLayerName }) {
            return
        }
        layer.addSublayer(_animationLayer)
    }
    
    private func _configureAnimationLayerRotation() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotation.duration = 1.0 / Double(_revolutionsPerSecond)
        rotation.removedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = kCAFillModeForwards
        rotation.fromValue = NSNumber(double: 0.0)
        rotation.toValue = NSNumber(double: 2.0 * M_PI)
        _animationLayer.addAnimation(rotation, forKey: "rotate")
    }
    
    private func _stop() {
        _isAnimating = false

        let timeOffset = _animationLayer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        _animationLayer.speed = 0.0
        _animationLayer.timeOffset = timeOffset
        
        if hidesWhenStopped {
            hidden = true
        }
    }
    
    private func _start() {
        _isAnimating = true
        
        let timeOffset : CFTimeInterval = _animationLayer.timeOffset
        
        _animationLayer.speed = 1.0
        _animationLayer.timeOffset = 0.0
        _animationLayer.beginTime = 0.0
        
        let timeSinceOffset = _animationLayer.convertTime(CACurrentMediaTime(), fromLayer: nil) - timeOffset
        _animationLayer.beginTime = timeSinceOffset
    }
    
    public func stopAnimating() {
        guard _isAnimating else {
            return
        }
        _stop()
    }
    
    public func startAnimating() {
        if _isAnimating {
            return
        }
        if hidden {
            hidden = false
        }
        _start()
    }
}
