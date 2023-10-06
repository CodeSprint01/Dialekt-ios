//
//  PayVC.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import UIKit
import Stripe

class PayVC: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var tfExpiryDate: UITextField!
//    @IBOutlet weak var tfCardNumber: UITextField!
    @IBOutlet weak var tfCvv: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var totalAmountView: UIView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var PayButton: UIButton!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tfCardNumber: STPPaymentCardTextField!
//    @IBOutlet weak var tfCardNumber: STPFormTextField!
    
    var shopItem : ListShopItemsModelDataClass? = nil
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        PayButton.addTarget(self, action: #selector(PayButtonClicked), for: .touchUpInside)
        tfName.delegate = self
        tfCvv.delegate = self
        tfExpiryDate.delegate = self
//        tfCardNumber.delegate = self
        givePaddingTo(textField: tfName)
//        givePaddingTo(textField: tfCvv)
//        givePaddingTo(textField: tfExpiryDate)
//        givePaddingTo(textField: tfCardNumber)
//        tfCardNumber.typ
        //data population
        totalAmountLabel.text = shopItem?.price ?? ""
      
    
    }
    
    //MARK:- PADDING TO TF
    func givePaddingTo(textField : UITextField) {
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
    }
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
//        self.tfCvv.giveShadow(self.tfCvv.bounds.height/2)
        self.tfName.giveShadow(self.tfCvv.bounds.height/2)
//        self.tfExpiryDate.giveShadow(self.tfCvv.bounds.height/2)
        self.tfCardNumber.giveShadow(self.tfCvv.bounds.height/2)
        self.totalAmountView.giveShadow()
        self.PayButton.setTitleColor(.white, for: UIControl.State.init())
        self.PayButton.backgroundColor = MainColor
        self.PayButton.giveShadow()
        self.view.layoutIfNeeded()
    }
    
    
    //MARK:- BUTTON ACTION
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func PayButtonClicked(){
        getToken()
    }
    
    
    private func getToken(){
            let cardParams = STPCardParams()
           cardParams.number = tfCardNumber.cardNumber
           cardParams.cvc = tfCardNumber.cvc
           cardParams.name = tfName.text?.trimmed() ?? ""
           cardParams.expYear = UInt(tfCardNumber.expirationYear)
           cardParams.expMonth = UInt(tfCardNumber.expirationMonth)
           STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
                guard let token = token, error == nil else {
                    Toast.show(message: "Error : \(error?.localizedDescription ?? "")", controller: self)
                    return
                }
            PrintToConsole("token \(token.tokenId)")
          //  self.apiCallForPayment(token.tokenId)
            }
        }
    

}


extension PayVC : UITextFieldDelegate {
    //MARK:- TEXT FIELD SHOULD RETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfName {
            tfCardNumber.becomeFirstResponder()
        }
        else if textField == tfCardNumber {
//            tfExpiryDate.becomeFirstResponder()
            textField.resignFirstResponder()
        }
//        else if textField == tfExpiryDate {
//            tfCvv.becomeFirstResponder()
//        }
//        else {
//            tfCvv.resignFirstResponder()
//        }
        return true
    }
}
