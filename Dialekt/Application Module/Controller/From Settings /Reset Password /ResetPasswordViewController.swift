//
//  ResetPasswordViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 13/05/21.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    
    //MARK:- OUTLETS
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfCurrentPassword: UITextField!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
   
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNewPassword.delegate = self
        tfConfirmPassword.delegate = self
        tfCurrentPassword.delegate = self

    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        saveButton.giveShadow()
    }

    
    //MARK:- BUTTON ACTIONS
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        let currentPassword = tfCurrentPassword.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let newPassword = tfNewPassword.text?.trimmed() ?? ""
        let confirmPassword = tfConfirmPassword.text?.trimmed() ?? ""
        
        if currentPassword == "" || newPassword == "" || confirmPassword == "" {
            Toast.show(message: "All Fields Required!", controller: self)
        }
        else if newPassword != confirmPassword {
            Toast.show(message: "New Password and Confirm Password do not match !", controller: self)
        }
        else {
            apiCallForChangePassword(currentPassword, NEW:newPassword)
        }
    }
    
}


extension ResetPasswordViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfCurrentPassword {
            tfNewPassword.becomeFirstResponder()
        }else
        if textField == tfNewPassword {
            tfConfirmPassword.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return true
    }
}
