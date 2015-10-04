//
//  RadialProgressView.swift
//  Closures
//
//  Created by Anil Kothari on 11/08/15.
//  Copyright (c) 2015 Anil Kothari. All rights reserved.
//

import QuartzCore
import UIKit

@IBDesignable
class RadialProgressView: UIView {

    var backGroundLayer: CAShapeLayer!

    var ringLayer: CAShapeLayer!

    var imageLayer: CALayer!
    @IBInspectable var image : UIImage? {
        didSet { updateProperties() }
    }
    
    @IBInspectable var lineWidth : CGFloat = 10{
        didSet { updateProperties() }
    }
    
    @IBInspectable var progress : CGFloat = 0.6{
        didSet { updateProperties() }
    }

    func rotate(){
        
        let anim: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        anim.timingFunction = CAMediaTimingFunction(name:"easeInEaseOut")
        anim.fromValue = NSNumber(float: 0.0)
        anim.delegate = self;
        anim.toValue = NSNumber(float:0.6)
        anim.repeatCount = 1
        anim.duration = 1
        ringLayer.addAnimation(anim, forKey:"strokeEnd")
        
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool){
        if (flag == true){
            ringLayer.strokeEnd = progress
         }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (backGroundLayer == nil){
            backGroundLayer = CAShapeLayer()
            layer.addSublayer(backGroundLayer)
            
            let rect = CGRectInset(bounds, lineWidth/2, lineWidth/2)
            let beizerPath = UIBezierPath(ovalInRect: rect)
            
            backGroundLayer.path = beizerPath.CGPath
            backGroundLayer.fillColor = nil
            backGroundLayer.strokeColor = UIColor(white: 0.5, alpha: 0.5).CGColor
            
            backGroundLayer.lineWidth = lineWidth
        }
        backGroundLayer.frame = layer.bounds

        
        
        if (ringLayer == nil){
            ringLayer = CAShapeLayer()
            
            let rect = CGRectInset(bounds, lineWidth/2, lineWidth/2)
            let beizerPath = UIBezierPath(ovalInRect: rect)
            
            ringLayer.path = beizerPath.CGPath
            ringLayer.fillColor = nil
            ringLayer.strokeColor = UIColor.blueColor().CGColor
            
            ringLayer.lineWidth = lineWidth
            ringLayer.anchorPoint = CGPointMake(0.5, 0.5)
            
             ringLayer.transform = CATransform3DRotate(ringLayer.transform, CGFloat(-M_PI_2), 0,0,1)

            layer.addSublayer(ringLayer)
        }
        ringLayer.frame = layer.bounds
        
        
        if (imageLayer == nil){
            
            
            let imageMaskLayer = CAShapeLayer()
            
            let rect = CGRectInset(bounds, lineWidth+2, lineWidth+2)
            let beizerPath = UIBezierPath(ovalInRect: rect)
            
            imageMaskLayer.path = beizerPath.CGPath
            imageMaskLayer.fillColor = UIColor.blackColor().CGColor
            imageMaskLayer.frame = bounds
            layer.addSublayer(imageMaskLayer)
            
            
            imageLayer = CALayer()
            
            imageLayer.mask = imageMaskLayer
            imageLayer.frame = bounds
            imageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(imageLayer)

            
        }
        
        updateProperties()
        
    }
    
    
    func updateProperties(){
        
        if (ringLayer != nil) {
            ringLayer.strokeEnd = progress
        }
        
        if (imageLayer != nil){
            if let i = image{
                imageLayer.contents = i.CGImage
            }
        }
        
    }

}
