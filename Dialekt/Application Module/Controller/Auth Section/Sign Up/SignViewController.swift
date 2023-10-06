//
//  SignViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 07/05/21.
//

import UIKit

class SignViewController: UIViewController {

    
    
    //MARK:- OUTLETS
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfLanguage: UITextField!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tickView: UIView!
    
    var selectedLanguage = ""
    var selectedCity = ""
    var selectedLevel = "1" // 1, 2, 3 in increasing order
    var isTermsAccepted = false
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfEmail.delegate = self
        tfPassword.delegate = self
        tfName.delegate = self
        tfLanguage.delegate = self
        tfCity.delegate = self
        loginLabel.makeClickable(target: self, selector: #selector(GoToLoginPage))
        SignupLabelText()
        tickView.layer.borderWidth = 1
        tickView.layer.borderColor = MainColor.cgColor
        
        tfCity.text = self.selectedCity
        tfLanguage.text = self.selectedLanguage
        
        NotificationCenter.default.addObserver(self, selector: #selector(SelectedCity), name: NSNotification.Name.init("updateCity"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SelectedLanguage(_:)), name: NSNotification.Name.init("updateLanguage"), object: nil)
      
    }
    
    
    //MARK:- NOTIFICATION METHODS
    @objc func SelectedCity(_ noti : Notification) {
        if let userInfo = noti.userInfo as? [String:String] {
            if let city = userInfo["city"] {
                tfCity.text = city
            }
        }
    }
    
    
    @objc func SelectedLanguage(_ noti : Notification) {
        if let userInfo = noti.userInfo as? [String:String] {
            if let city = userInfo["language"] {
                tfLanguage.text = city
            }
        }
    }
    
    
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in stackView.arrangedSubviews {
        view.giveShadow()
        }
        signupButton.giveShadow()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
       
    }
    
    //MARK:- Go For Login
    func goTohomePage(){
        if let window = GetWindow(), let vc = R.storyboard.home.homeViewController() {
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        window.rootViewController = nav
        window.makeKeyAndVisible()
        }
    }
    
    
    //MARK:- BUTTON ACTIONS
    @IBAction func signupButtonPressed(_ sender: Any) {
        
        guard isTermsAccepted else {
            Toast.show(message: "Please Accept Terms and Conditions !", controller: self)
            return
        }
        let name = tfName.text?.trimmed() ?? ""
        let password = tfPassword.text?.trimmed() ?? ""
        let city = tfCity.text?.trimmed() ?? ""
        let language = tfLanguage.text?.trimmed() ?? ""
        let email = tfEmail.text?.trimmed() ?? ""
        
        if name == "" || name == "" || name == "" || name == "" || name == "" {
            Toast.show(message: "All Fields are required !", controller: self)
        }else if !email.isEmail {
            Toast.show(message: "Invalid Email !", controller: self)
        }else {
            apiCallForRegistration(email, password: password, city: city, language: language, name: name)
        }
    }
    
    
    @IBAction func tickButtonPressed(_ sender: Any) {
        
        if tickImage.image == nil {
            tickImage.image = R.image.check()
            isTermsAccepted = true
        }else {
            tickImage.image = nil
            isTermsAccepted = false
        }
        
    }
    
    @IBAction func PlusButtonOnLanguageTf(_ sender: Any) {
        if let vc = R.storyboard.initialTests.selectDialectViewController(){
            vc.isFromSignUp = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func PlusButtonOnCityTf(_ sender: Any) {
        if let vc = R.storyboard.initialTests.selectCityViewController(){
            vc.isFromSignUp = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func GoToLoginPage(){
      //  self.navigationController?.popViewController(animated: true)
      // Poping to root view controller now
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    //MARK:- ATTRIBUTED TEXT TO SINGUP LABEL
    func SignupLabelText() {
    let attriString = NSAttributedString(string:"Already have an account? ", attributes:
        [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
         NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 17.0)!])
    let attriString2 = NSAttributedString(string:"Login", attributes:
        [NSAttributedString.Key.foregroundColor: MainColor,
         NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 17.0)!])
    let attributedString2 = NSMutableAttributedString(attributedString: attriString2)
    attributedString2.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attriString2.length))
    let combination = NSMutableAttributedString()
    combination.append(attriString)
    combination.append(attributedString2)
    loginLabel.attributedText = combination
}

}
