//
//  Login + textField.swift
//  Dialekt
//
//  Created by Vikas saini on 07/05/21.
//

import Foundation
import UIKit


extension LoginViewController : UITextFieldDelegate {

    //MARK:- TEXTFIELD SHOULD RETURN
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfEmail {
            tfEmail.resignFirstResponder()
            tfPassword.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
