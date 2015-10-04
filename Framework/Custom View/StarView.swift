//
//  StarView.swift
//  Closures
//
//  Created by Anil Kothari on 06/09/15.
//  Copyright (c) 2015 Rakesh Kothari. All rights reserved.
//

import UIKit

@IBDesignable

class StarView: UIView {
    
    var starArray : [Star] = []

    
    var rating : Int = 3 {
        didSet {
            updateProperty()
        }
    }
    
    func updateProperty(){
        var counter = 0;
        counter++;

        for star in starArray{
            
            if (rating > counter) {
                 star.setColor( UIColor.yellowColor().CGColor)
            }else{
                star.setColor( UIColor.grayColor().CGColor)
             }
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.width/5
        var spacing = 4
        
        for i in 0...4{
        
            spacing += spacing
            
            let star = Star()
            
            let xOrigin = CGFloat( CGFloat(i) * width)
            star.frame = CGRectMake( xOrigin , 0.0, 36.0, 32.0)
            
            
             starArray.append(star)
            addSubview(star)
            
        }
        
     }
    

    override func drawRect(rect: CGRect){
        super.drawRect(rect)
        
     }

    
}


  class Star: UIView {

    var starLayer : CAShapeLayer!
    
    var bgLayer : CAShapeLayer!
    
    
    func setColor(color : CGColorRef){
        starLayer.fillColor = color
    }
    
     override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let lineWidth : CGFloat = 6
        
        if bgLayer == nil{
            
            bgLayer = CAShapeLayer()
            
            let rect  = CGRectInset(bounds, lineWidth/2, lineWidth/2)
            bgLayer.path = UIBezierPath(ovalInRect: rect).CGPath
            bgLayer.fillColor = nil
            layer.addSublayer(bgLayer)
        }
        
        
            if (starLayer == nil) {
                starLayer = CAShapeLayer()
                
                let path = UIBezierPath()
                //top point
                path.moveToPoint(CGPointMake(bounds.width/2, 0))
                
                //bottom right
                path.addLineToPoint(CGPointMake(bounds.width * 0.9 , bounds.height*0.77))
                
                //bottom left
                path.addLineToPoint(CGPointMake(bounds.width * 0.1, bounds.height*0.77))

                //top left
                path.addLineToPoint(CGPointMake(bounds.width/2, 0))

                
                // mid left
                path.moveToPoint(CGPointMake(bounds.width * 0.1,bounds.height/3))
                
                // mid right
                path.addLineToPoint(CGPointMake(bounds.width*0.9,bounds.height/3))
                
                //bottom center
                path.addLineToPoint(CGPointMake(bounds.width/2,bounds.height))

                // mid left
                path.addLineToPoint(CGPointMake(bounds.width * 0.1,bounds.height/3))

                
                starLayer.fillColor = UIColor.yellowColor().CGColor
                starLayer.path = path.CGPath
                starLayer.lineWidth = 1
                starLayer.strokeColor = UIColor.redColor().CGColor
                starLayer.strokeColor = UIColor.blackColor().CGColor

                bgLayer.addSublayer(starLayer)

            
            }
        
  
      }

    
    
    
    
    
}
