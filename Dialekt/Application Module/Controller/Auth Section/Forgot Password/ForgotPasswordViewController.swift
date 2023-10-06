//
//  ForgotPasswordViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 09/05/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    
    //MARK:- OUTLETS
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var ContinueButton: UIButton!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var roundView2: UIView!
    @IBOutlet weak var RoundView1: UIView!
    
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.delegate = self
        roundView2.roundViewCorner(radius: self.roundView2.bounds.height / 2)
        RoundView1.roundViewCorner(radius: self.RoundView1.bounds.height / 2)

    }
    
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        EmailView.giveShadow()
        ContinueButton.giveShadow()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
       
    }
    
    
    
    //MARK:- BUTTON ACTIONS
    @IBAction func ContinueButtonAction(_ sender: Any) {
        let emailAddress = tfEmail.text?.trimmed() ?? ""
        if emailAddress == "" || !emailAddress.isEmail {
            Toast.show(message: "Please Enter a Valid Email address...", controller: self)
        }else {
            apiCallForSendingResetPasswordLink(emailAddress)
        }
     }
    
    @IBAction func GoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ForgotPasswordViewController : UITextFieldDelegate {

    //MARK:- TEXTFIELD SHOULD RETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
