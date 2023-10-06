//
//  UIWindowExtension.swift
//  BaseProject
//
//  Created by Techwin on 21/12/20.
//

import Foundation
import UIKit

extension UIWindow {
  
//MARK:- TOP VIEW CONTROLLER
//CONTRIBUTED BY LEKHA MA'AM
    
    //GET THE TOPMOST VIEW CONTROLLER ON ANY CONTROLLER OF APPLICATION
    
      func topViewController() -> UIViewController? {
      var top = self.rootViewController
      while true {
          if let presented = top?.presentedViewController {
              top = presented
          } else if let nav = top as? UINavigationController {
              top = nav.visibleViewController
          } else if let tab = top as? UITabBarController {
              top = tab.selectedViewController
          } else {
              break
          }
      }
      return top
  }
}

//USAGE :
//if let currentVC = UIApplication.shared.keyWindow?.topViewController() {
//
//}
