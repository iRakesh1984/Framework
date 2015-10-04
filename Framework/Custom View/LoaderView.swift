//
//  MenuView.swift
//  Closures
//
//  Created by Anil Kothari on 20/08/15.
//  Copyright (c) 2015 Rakesh Kothari. All rights reserved.
//

import UIKit

@IBDesignable

class LoaderView: UIView {
 

    var ringLayer: CAShapeLayer!
    
    var imageLayer: CALayer!
    
     var progressLayer : CAShapeLayer!

    @IBInspectable var image : UIImage? {
        didSet { updateProperties() }
    }
    
    @IBInspectable var lineWidth : CGFloat = 10{
        didSet { updateProperties() }
    }
    
    var ringPath : UIBezierPath!
    
    
    
    func rotate(){
        
        let anim: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        anim.timingFunction = CAMediaTimingFunction(name:"linear")
        anim.fromValue = CGFloat(-M_PI_2)
        anim.toValue = CGFloat(M_PI + M_PI_2)
        anim.repeatCount = 15
        anim.duration = 2
        progressLayer.addAnimation(anim, forKey:"transform")
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
 
        if (ringLayer == nil){
            ringLayer = CAShapeLayer()
            
            let rect = CGRectInset(bounds, lineWidth/2, lineWidth/2)
            
            ringPath = UIBezierPath(ovalInRect: rect)
            
            ringLayer.path = ringPath.CGPath
            ringLayer.fillColor = nil
            ringLayer.strokeColor = UIColor.blueColor().CGColor
            
            ringLayer.lineWidth = lineWidth

            ringLayer.strokeEnd = 1.0;
            ringLayer.lineDashPhase = 5;
            
             let num = NSNumber(int: 25)
            let num1 = NSNumber(int: 10)
            
            ringLayer.lineDashPattern = [num,num1]
 
            layer.addSublayer(ringLayer)
        }
         
        
        
        
        ringLayer.frame = layer.bounds

        
        
        
        
        if (progressLayer == nil){
            progressLayer = CAShapeLayer()
            
            let rect = CGRectInset(bounds, lineWidth/2, lineWidth/2)
            
            let path = UIBezierPath(ovalInRect: rect)
            
            progressLayer.path = path.CGPath
            progressLayer.fillColor = nil
            progressLayer.strokeColor = UIColor.grayColor().CGColor
            
            progressLayer.lineWidth = lineWidth
            
            progressLayer.strokeStart = 0.09
            progressLayer.strokeEnd = 0.26;
            progressLayer.lineDashPhase = 5;
            let num = NSNumber(int: 34)
            let num1 = NSNumber(int: 13)
            
            progressLayer.lineDashPattern = [num,num1]
               progressLayer.transform = CATransform3DRotate(progressLayer.transform, CGFloat(-M_PI_2), 0,0,1)

            ringLayer.addSublayer(progressLayer)
        }
        
        progressLayer.frame = layer.bounds

        
 
        
        
        if (imageLayer == nil){
            
            
            let imageMaskLayer = CAShapeLayer()
            
            let rect = CGRectInset(bounds, lineWidth+2, lineWidth+2)
            let beizerPath = UIBezierPath(ovalInRect: rect)
            
            imageMaskLayer.path = beizerPath.CGPath
            imageMaskLayer.frame = bounds
            layer.addSublayer(imageMaskLayer)
            
            imageLayer = CALayer()
            imageLayer.mask = imageMaskLayer
            imageLayer.frame = bounds
            imageLayer.contentsGravity = kCAGravityCenter
            layer.addSublayer(imageLayer)
            
            
        }
        
        updateProperties()
     }
    
 
    
    func updateProperties(){
        
        if (imageLayer != nil){
            if let i = image{
                imageLayer.contents = i.CGImage
            }
        }
        
    }
    
}
