//
//  Signup + TextField.swift
//  Dialekt
//
//  Created by Vikas saini on 07/05/21.
//

import Foundation
import UIKit


extension SignViewController : UITextFieldDelegate {

    //MARK:- TEXTFIELD SHOULD RETURN
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfName {
            tfCity.becomeFirstResponder()
        }else if textField == tfCity {
            tfLanguage.becomeFirstResponder()
        }else if textField == tfLanguage {
            tfEmail.becomeFirstResponder()
        }else if textField == tfEmail {
            tfPassword.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    //MARK:-  TEXTFIEL
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
    }
    
}
