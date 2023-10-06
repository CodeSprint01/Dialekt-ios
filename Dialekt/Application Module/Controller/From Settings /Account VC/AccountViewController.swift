//
//  AccountViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 12/05/21.
//

import UIKit

class AccountViewController: UIViewController {

    
    //MARK:- OUTLETS
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var editProfilePicView: UIView!
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    
    //MARK:- CLASS VARIABLES AND CONSTANTS
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.delegate = self
        tfEmail.delegate = self
        tfName.isUserInteractionEnabled = false
        tfEmail.isUserInteractionEnabled = false
        apiCallForGetProfile()
        self.personImageView.sd_setImage(with: URL(string: IMAGE_BASE_URL + (UserDefaults.standard.string(forKey: UD_USERIMAGE) ?? "")), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
    }
    
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in stackView.arrangedSubviews {
            view.giveShadow()
        }
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        saveButton.giveShadow()
        editProfilePicView.roundViewCorner(radius: self.editProfilePicView.bounds.height / 2)
        personImageView.roundViewCorner(radius: self.personImageView.bounds.height / 2)
       
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func makeEmailEditableAction(_ sender: Any) {
        tfEmail.isUserInteractionEnabled = true
    }
    
    @IBAction func makeNameEditableAction(_ sender: Any) {
        tfName.isUserInteractionEnabled = true
    }
    
    @IBAction func changePasswordAction(_ sender: Any) {
        if let vc = R.storyboard.settings.resetPasswordViewController(){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func profilePicButtonAction(_ sender: Any) {
        MediaPicker.shared.showAttachmentActionSheet(vc: self)
        MediaPicker.shared.imagePickedBlock = { image in
            self.personImageView.image = image
        }
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let email = tfEmail.text?.trimmed() ?? ""
        let name = tfName.text?.trimmed() ?? ""
        if email == ""  {
            Toast.show(message: "Please Enter Email address..", controller: self)
        }else if name == "" {
            Toast.show(message: "Please Enter Name..", controller: self)
        }else if !email.isEmail {
            Toast.show(message: "Please Enter Valid Email address..", controller: self)
        }else {
            let param = ["email": email , "name" : name] as [String: Any]
            apicallForupdateProfile(dict: param, image: self.personImageView.image!)
        }
    }
    
}



extension AccountViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfName {
            tfEmail.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return true
    }
}
