//
//  MenuView.swift
//  Closures
//
//  Created by Anil Kothari on 20/08/15.
//  Copyright (c) 2015 Rakesh Kothari. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable

class Menu: UIView {
    
    
    var view1 : UIView!
    var view2 : UIView!
    var view3 : UIView!

    var cross : Bool = false
    var tapGesture : UITapGestureRecognizer!
    
    override func drawRect(rect: CGRect) {
        
        let padding = rect.height/5
        
        view1 = UIView(frame:CGRectMake(rect.origin.x, rect.origin.y, rect.width , padding))
        view1.backgroundColor = UIColor.redColor()
        self.addSubview(view1)
    
        view2 = UIView(frame:CGRectMake(rect.origin.x, rect.origin.y + padding*2, rect.width , padding))
        view2.backgroundColor = UIColor.redColor()
        self.addSubview(view2)
        
        
        view3 = UIView(frame:CGRectMake(rect.origin.x, rect.origin.y + padding*4, rect.width , padding))
        view3.backgroundColor = UIColor.redColor()
        self.addSubview(view3)
        
        
        tapGesture = UITapGestureRecognizer()
        tapGesture.numberOfTapsRequired = 1
        
        tapGesture.addTarget(self, action: "call")
    self.addGestureRecognizer(tapGesture)
    }
    
    func call(){
    cross = !cross
        
    view2.hidden = cross
        
        //set anchor point and translate
        view1.layer.anchorPoint = CGPointMake(0, 0)
        view3.layer.anchorPoint = CGPointMake(1, 1)
        
        
        self.view1.transform = CGAffineTransformMakeTranslation(-self.view1.frame.size.width/2, 0)
        self.view3.transform = CGAffineTransformMakeTranslation(self.view3.frame.size.width/2, 0)

 
        UIView.animateWithDuration(NSTimeInterval(0.45), animations: { () -> Void in
            if self.cross{
                self.view1.transform = CGAffineTransformMakeRotation(CGFloat( M_PI_4))
                self.view3.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4))
                
            }else
            {
                self.view3.transform = CGAffineTransformMakeRotation(CGFloat( M_PI_4))
                self.view1.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_4))
                
            }
        })
     
    }
}

@IBDesignable

class Icon : UIView {
    
    var iconLayer : CAShapeLayer!
    
    var path : UIBezierPath!

    var yInset : CGFloat = 6
    
    var xInset : CGFloat = 10
    
    @IBInspectable
 var color : UIColor = UIColor.greenColor()
        {
        didSet { updateProperties() }
    }

    
    @IBInspectable

    var selected : Bool = false{
        didSet { updateColor() }
    }

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch : NSSet = touches
        
        let currentPoint = touch.anyObject()!.locationInView(self)
        
        if CGPathContainsPoint(iconLayer.path, nil, currentPoint, false) {
            selected = !selected
        }
        
        
    }
    
    
    
    
    override func drawRect(rect: CGRect) {
        iconLayer = CAShapeLayer()
        
        iconLayer.fillColor = nil
        iconLayer.strokeColor = color.CGColor
        
        layer.addSublayer(iconLayer)
        
        iconLayer.frame = layer.bounds
        
        
        self.updateProperties()
    
    }
    
    
    func updateColor(){
        if (iconLayer != nil){
            iconLayer.strokeColor = color.CGColor
        if (selected){
            iconLayer.fillColor = color.CGColor
            }
        else{
            iconLayer.fillColor = nil
            }
            
            
            iconLayer.removeAllAnimations()

        
        let animation  = CABasicAnimation(keyPath: "opacity")
        
        animation.duration = 2.0
        animation.autoreverses = false
        animation.fromValue = NSNumber(int: 0)
        animation.toValue = NSNumber(int: 1)

        iconLayer.addAnimation(animation, forKey: "change")
        }

    }
 
    func updateProperties() {
        
            let rect = CGRectInset(bounds, xInset, yInset)
            
            let path = UIBezierPath()
            
            let point = CGPointMake(rect.origin.x + rect.size.width/2, rect.size.height  + rect.origin.y)
            
            path.moveToPoint(point)
            
            
            let y = CGFloat(rect.size.height*0.5)
            
            let radius = CGFloat(rect.size.width/4)
            
            path.addLineToPoint(CGPointMake(rect.origin.x, radius  + rect.origin.y))
            
            
            path.addArcWithCenter(CGPointMake(rect.origin.x + radius, radius + rect.origin.y), radius: radius, startAngle: CGFloat(M_PI * 1.0) , endAngle:0 , clockwise: true)
            
            path.addArcWithCenter(CGPointMake(rect.origin.x + radius*3, radius  + rect.origin.y), radius: radius, startAngle: CGFloat(M_PI * 1.0), endAngle: 0, clockwise: true)
        
            path.addLineToPoint(point)
        
        if (iconLayer != nil){
            iconLayer.path = path.CGPath
        }

        
    }
    
}





@IBDesignable

class SegmentControl : UIView {
    
    var iconLayer : [CAShapeLayer] = []
    
    var numberOfSegment : Int = 3
    
    var selectedSegment : Int = -1

    var previousSelectedSegment : Int = -1

    var baseRect : CGRect?

    @IBInspectable
    var color : UIColor = UIColor.greenColor()
        {
        didSet { updateProperties() }
    }
    
    
    @IBInspectable
    
    var selected : CAShapeLayer?
        {
        didSet { updateSelectedLayer(selected) }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch : NSSet = touches
        
        let currentPoint = touch.anyObject()!.locationInView(self)
        
        for layer in iconLayer{
            if CGPathContainsPoint(layer.path, nil, currentPoint, false) {
                selected = layer
            }
        }
        
        
        
    }
    
    
    override func layoutSubviews() {
        
        for layer in iconLayer{
            layer.removeFromSuperlayer()
        }
        iconLayer = []

        drawLayers()
    
        
        updateSelectedLayerIndex(selectedSegment)
    }
    
    
    func drawLayers(){
        
            let height = frame.size.height
            
            let width = frame.size.width / CGFloat(numberOfSegment)
            
            baseRect = CGRectMake(0, 0, width, height)
            
            for i in 0..<numberOfSegment {
                
                layer.addSublayer(createLayer())
                
//                if selectedSegment>0{
//                    updateSelectedLayerIndex(selectedSegment)
//                }
                
                baseRect = CGRectOffset(baseRect!, width, 0)
            }
            
    }
    
    override func drawRect(rect: CGRect) {
        drawLayers()
    }
    
    func updateSelectedLayerIndex(index : Int){
        
        if (index > 0){
            let layer1 = iconLayer[index]
                
                 layer1.fillColor = color.CGColor
                layer1.strokeColor = color.CGColor
         }
       
     }
    
    func updateSelectedLayer(shapeLayer : CAShapeLayer?){
        
        if let selectedLayer = shapeLayer {
            selectedSegment = 0
            for layer in iconLayer{
            
                if layer == selectedLayer{
                 layer.fillColor = color.CGColor
                 layer.strokeColor = color.CGColor
                    
                    if (previousSelectedSegment != selectedSegment){

                        print("Selected Segment is \(selectedSegment)")
                        previousSelectedSegment = selectedSegment

                    }
                    
                
                }else{
                   layer.fillColor = nil
                    selectedSegment += 1
                }
                
            }
        }
        
    }
    
        func createLayer() -> CAShapeLayer{
            
            let layer = CAShapeLayer()
            
            layer.fillColor = nil
            
            layer.path = UIBezierPath(rect: baseRect!).CGPath
            
             layer.strokeColor = color.CGColor
            
             
            iconLayer.append(layer)
            
            return layer
            
        }
    
        func updateColor(){
            
            if let selectedLayer = selected{
            
            for layer in iconLayer{
                
                if layer == selected{
                    layer.fillColor = color.CGColor
                }else{
                    layer.fillColor = nil
                }
                
            }
            
            }
        }
    
    
        func updateProperties() {
            
        }
    
}



