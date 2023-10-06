//
//  UIImageViewExtension.swift
//  BaseProject
//
//  Created by Techwin on 21/12/20.
//

import Foundation
import  UIKit


extension UIImageView {
    
    //MARK:- CORNER RADIUS OF IMAGEVIEW
    //CONTRIBUTED BY INDERJEET SINGH
    
func roundImgCorner(radius : CGFloat){
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
}

}
