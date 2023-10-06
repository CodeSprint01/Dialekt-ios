//
//  UIDeviceExtensions.swift
//  DummyProject
//
//  Created by Techwin on 10/02/21.
//

import Foundation
import AudioToolbox
import  AVKit


//MARK:- UIDEVICE EXTENSIONS
//CONTRIBUTED BY VIKAS SAINI ON FEB 10 , 2020



//UIDEVICE EXTENSION FOR VIBRATE
//UIDEVICE EXTENSION FOR SIMUATOR DETECTION
//UIDEVICE EXTENSION FOR NOTCH DETECTION

extension UIDevice {
    
    //vibrate devie
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    //usage : UIDevice.vibrate()
    
    
    //check if current device is simulator or real device
    var isSimulator: Bool {
            #if IOS_SIMULATOR
                return true
            #else
                return false
            #endif
        }
    //usage : if UIDeive.current.isSimulator {}else {}
    
    
    //checking if current device has a notch
     var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
    //usage : if UIDeive.current.hasNotch {}else {}

}
