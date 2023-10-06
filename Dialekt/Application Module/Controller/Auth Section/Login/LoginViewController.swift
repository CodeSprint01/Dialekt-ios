//
//  LoginViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 07/05/21.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    //MARK:- OUTLETS
    
    @IBOutlet weak var viewBehindAppleIcon: UIView!
    @IBOutlet weak var viewBehindFacebookIcon: UIView!
    @IBOutlet weak var viewBehindGoogleIcon: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var appleView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var googleView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPaswordButton: UIButton!
    @IBOutlet weak var signupLabel: UILabel!
    
    
    //MARK:- CLASS VARIABLES
    let loginManager = LoginManager()
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tfEmail.delegate = self
        tfPassword.delegate = self
        signupLabel.makeClickable(target: self, selector: #selector(GoToSignupPage))
        SignupLabelText()
        forgotPaswordButton.addTarget(self, action: #selector(ForgotPasswordClicked), for: UIControl.Event.touchUpInside)
        loginButton.addTarget(self, action: #selector(LoginClicked), for: .touchUpInside)
        
        if #available(iOS 13.0, *) {} else {
            appleView.isHidden = true
        }
        //Logging out facebook everytime when user see this screen , purely to avoid conflictions in testing
        loginManager.logOut()
        //Google Sign In
//        GIDSignIn.sharedInstance()?.presentingViewController = self //koti
//        GIDSignIn.sharedInstance()?.delegate = self //koti
        //Logging out google everytime when user see this screen,
        if GIDSignIn.sharedInstance.currentUser == nil{}else {
            GIDSignIn.sharedInstance.signOut()
        }
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        EmailView.giveShadow()
        PasswordView.giveShadow()
        facebookView.giveShadow()
        googleView.giveShadow()
        appleView.giveShadow()
        loginButton.giveShadow()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75 
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        viewBehindAppleIcon.roundCorners(corners: [.topLeft , .bottomLeft], radius: 8)
        viewBehindFacebookIcon.roundCorners(corners: [.topLeft , .bottomLeft], radius: 8)
        viewBehindGoogleIcon.roundCorners(corners: [.topLeft , .bottomLeft], radius: 8)
    }
    
    //MARK:- ATTRIBUTED TEXT TO SINGUP LABEL
    func SignupLabelText() {
    let attriString = NSAttributedString(string:"Don't have an account? ", attributes:
        [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
         NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 17.0)!])
        //Sign Up text Change to Get Started here
    let attriString2 = NSAttributedString(string:"Get Started", attributes:
        [NSAttributedString.Key.foregroundColor: MainColor,
         NSAttributedString.Key.font: UIFont(name: "Poppins-SemiBold", size: 17.0)!])
    let attributedString2 = NSMutableAttributedString(attributedString: attriString2)
    attributedString2.addAttribute(NSMutableAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attriString2.length))
    let combination = NSMutableAttributedString()
    combination.append(attriString)
    combination.append(attributedString2)
    signupLabel.attributedText = combination
}
    
    
    
    //MARK:- BUTTON ACTIONS
    
    @IBAction func facebookClicked(_ sender: Any) {
        self.facebookLogin()

    }
    
    @IBAction func appleClicked(_ sender: Any) {
        if #available(iOS 13.0, *) {
            handleAppleIdRequest()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func googleLoginClicked(_ sender: Any) {
        self.googleSignIn(viewController: self)
    }
    
    @objc func GoToSignupPage(){
    self.navigationController?.popViewController(animated: true )
//    GOIING BACK NOW , THE FLOW HAS BEEN CHANGED
//        if let vc = R.storyboard.auth.signViewController() {
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    @objc func ForgotPasswordClicked() {
        if let vc = R.storyboard.auth.forgotPasswordViewController(){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK:- login button click listener
    @objc func LoginClicked(){
        let email = tfEmail.text?.trimmed() ?? ""
        let password = tfPassword.text?.trimmed() ?? ""
        if email == "" {
            Toast.show(message: "Please Enter Email...", controller: self)
        }else if password == "" {
            Toast.show(message: "Please Enter Password...", controller: self)
        }else if password.count < 6{
            Toast.show(message: "Password must be atleast 6 characters long...", controller: self)
        }else if !email.isEmail{
            Toast.show(message: "Please enter a valid email address...", controller: self)
        }else {
           apiCallForLogin(email, password: password)
        }
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
    
    //MARK:- GOOGLE SIGN IN
    //Not in use for now
//    func GoogleSignin(){ //koti
//        if GIDSignIn.sharedInstancecurrentUser == nil {
//            GIDSignIn.sharedInstance.signIn()
//        } else {
//            GIDSignIn.sharedInstance.signOut()
//        }
//    }
    
  
}

