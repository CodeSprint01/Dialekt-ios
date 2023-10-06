//
//  UIButtonExtension.swift
//  BaseProject
//
//  Created by Techwin on 21/12/20.
//

import Foundation
import UIKit

extension UIButton{
    
    //MARK:- CORNER RADIUS OF BUTTON
    //CONTRIBUTED BY INDERJEET SINGH
    func roundButtonCorner(radius : CGFloat){
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    
    //MARK:- GIVE BORDER TO BUTTON
    //CONTRIBUTED BY INDERJEET SINGH
    func GiveBorder(width : Double, color:UIColor){
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color.cgColor
    }
}
