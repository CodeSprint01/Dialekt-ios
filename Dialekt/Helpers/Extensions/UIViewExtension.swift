//
//  UIViewExtension.swift
//  BaseProject
//
//  Created by Techwin on 21/12/20.
//

import Foundation
import UIKit




 extension UIView {
    
    // MARK:- Custom Shadow to View
    //CONTRIBUTED BY INDERJEET SIR

    func addshadow(top: Bool,
                  left: Bool,
                  bottom: Bool,
                  right: Bool) {
       let path = UIBezierPath()
       var x: CGFloat = 0
       var y: CGFloat = 0
       var viewWidth = self.frame.width
       var viewHeight = self.frame.height
       
       // here x, y, viewWidth, and viewHeight can be changed in
       // order to play around with the shadow paths.
       if (!top) {
           y+=(0)
       }
       if (!bottom) {
           viewHeight-=(0)
       }
       if (!left) {
           x+=(0+1)
       }
       if (!right) {
           viewWidth-=(0)
       }
       // selecting top most point
       path.move(to: CGPoint(x: x, y: y))
       // Move to the Bottom Left Corner, this will cover left edges
       /*
        |☐
        */
       path.addLine(to: CGPoint(x: x, y: viewHeight))
       // Move to the Bottom Right Corner, this will cover bottom edge
       /*
        ☐
        -
        */
       path.addLine(to: CGPoint(x: viewWidth, y: viewHeight))
       // Move to the Top Right Corner, this will cover right edge
       /*
        ☐|
        */
       path.addLine(to: CGPoint(x: viewWidth, y: y))
       // Move back to the initial point, this will cover the top edge
       /*
        _
        ☐
        */
       path.close()
       self.layer.shadowPath = path.cgPath
   }
    
    
    
    //MARK:- ROUND VIEW CORNERS
    //CONTRIBUTED BY INDERJEET SINGH
    func roundViewCorner(radius : CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    
    
    //MARK:- ROUND CORNERS AND GIVING SHADOW
    //CONTRIBUTED BY VIKAS SAINI DATED 25 FEB 2021

    func giveShadowAndRoundCorners(shadowOffset: CGSize , shadowRadius : Int , opacity : Float , shadowColor : UIColor , cornerRadius :
    CGFloat){
        if cornerRadius > 0 {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        }
        DispatchQueue.main.async {
            self.layer.shadowPath =  UIBezierPath(roundedRect: self.bounds,cornerRadius: self.layer.cornerRadius).cgPath
        }
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOffset = shadowOffset
        self.layer.masksToBounds = false
    }
    //USAGE:- someView.giveShadowAndRoundCorners(shadowOffset: CGSize.zero, shadowRadius: 12, opacity: 0.8, shadowColor: Some_color, cornerRadius: 10)
    
    
    //MARK:- MARK PARTICULAR CORNERS OF A VIEW
    //CONTRIBUTED BY VIKAS SAINI DATED 25 FEB 2021
      func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    //USAGE:  someView.roundCorners(corners: [.topRight , .bottomLeft , .bottomRight], radius: 30)
    
    
    //MARK:- DRAW LINE FROM ONE POINT TO ANOTHER POINT
    //CONTRIBUTED BY VIKAS SAINI DATED 15 MARCH 2020
    
    func drawStraightLine(startingFrom : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor) {
        //design the path
        let path = UIBezierPath()
        path.move(to: startingFrom)
        path.addLine(to: end)
        //design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 4.0
        self.layer.addSublayer(shapeLayer)
    }
    
    //USAGE: YOURVIEW.drawStraightLine(startingFrom : SOMEPOINT , toPoint : ENDPOINT , ofColor: UIColor.red)
    
    

      
      
     //MARK:- R0UND BOTTOM EDGE
        func addBottomRoundedEdge(desiredCurve: CGFloat?) {
            let offset: CGFloat = self.frame.width / desiredCurve!
            let bounds: CGRect = self.bounds
            
            let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
            let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
            let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
            let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
            rectPath.append(ovalPath)
            
            // Create the shape layer and set its path
            let maskLayer: CAShapeLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = rectPath.cgPath
            
            // Set the newly created shape layer as the mask for the view's layer
            self.layer.mask = maskLayer
        }
    
    /* Usage Example
     * bgView.addBottomRoundedEdge(desiredCurve: 1.5)
     */
}

//MARK:- SPECIALLY FOR THIS PROJECT
extension UIView {
    func giveShadow(_ radius : CGFloat = 8.0, _ offset : CGSize = .zero){
        self.giveShadowAndRoundCorners(shadowOffset: offset, shadowRadius: 5, opacity: 0.7, shadowColor: .lightGray, cornerRadius: radius)
    }
    
    func makeClickable(target: Any, selector: Selector){
        self.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: target, action: selector)
        self.addGestureRecognizer(guestureRecognizer)
    }
}
