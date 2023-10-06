//
//  SettingsViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 12/05/21.
//

import UIKit

class SettingsViewController: UIViewController  , UITableViewDelegate , UITableViewDataSource{

    //MARK:- OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    let imagesArray = [#imageLiteral(resourceName: "user"),#imageLiteral(resourceName: "Terms"),#imageLiteral(resourceName: "lock"),#imageLiteral(resourceName: "review"),#imageLiteral(resourceName: "share"),#imageLiteral(resourceName: "logout")]
    let textArray = ["Account", "Terms & Conditions" , "Privacy Policy" , "Rate Us" , "Share on social Media", "Logout"]
    var selectedCell = 123456
    
    let optionsArray: [SettingOptions] = [.Account, .TermsAndConditions, .PrivacyPolicy, .RateUs, .ShareOnSocialMedia, .Logout]
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: R.reuseIdentifier.settingsTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.settingsTVC.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK:- TABLE VIEW DATASOURCE AND DELEGATES
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.settingsTVC.identifier, for: indexPath) as? SettingsTVC {
         cell.setupCell(image: imagesArray[indexPath.row], text: textArray[indexPath.row], isSelected: selectedCell == indexPath.row)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        switch optionsArray[indexPath.row] {
            
        case .Account:
            if let vc = R.storyboard.settings.accountViewController() {
                self.parent?.navigationController?.pushViewController(vc, animated: true)
            }
        case .TermsAndConditions:
            let vc = VC<WebViewerVC>.settings.instantiateVC()
            vc.fileUrl = URL(string: Credentials.TermsAndConditionURL)
            vc.titleText = "Terms & Conditions"
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .PrivacyPolicy:
            let vc = VC<WebViewerVC>.settings.instantiateVC()
            vc.fileUrl = URL(string: Credentials.PrivacyPolicyURL)
            vc.titleText = "Privacy Policy"
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .RateUs:
            AppStoreReviewManager.requestReview()
        case .ShareOnSocialMedia:
            let appLink = "APP_LINK_HERE"
            let items = ["Hey Buddy , I Found this amazing app for learning new dailects and enhancing your vocabulary, Have a look at : \(appLink)"]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(ac, animated: true)
        case .Logout:
            apiCallForLogout()
        }
        
        
//        if indexPath.row == 0 {
//            //Go to account vc
//            if let vc = R.storyboard.settings.accountViewController() {
//                self.parent?.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//        if indexPath.row == 1 {}
//        if indexPath.row == 2 {}
//        if indexPath.row == 3 {
//            //rate us
//            AppStoreReviewManager.requestReview()
//        }
//        if indexPath.row == 4 {
//            //share
//        let appLink = "APP_LINK_HERE"
//        let items = ["Hey Buddy , I Found this amazing app for learning new dailects and enhancing your vocabulary, Have a look at : \(appLink)"]
//        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
//        present(ac, animated: true)
//        }
//        if indexPath.row == 5 {
//            //logout
//            apiCallForLogout()
//        }
    }
    
    //MARK:- API CALL FOR LOGOUT
    func apiCallForLogout(){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        let params = [String: Any]()
      
        ApiManager.shared.Request(type: GeneralModel.self, methodType: .Post, url: BASE_URL + LOGOUT_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                PrintToConsole("response of logout api \(String(describing: response))")
                    DispatchQueue.main.async {
                        let domain = Bundle.main.bundleIdentifier!
                        UserDefaults.standard.removePersistentDomain(forName: domain)
                        UserDefaults.standard.synchronize()
                        self.goToFirstPage()
                    }
              
            } else {
                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
    
    
    //MARK:- Go To First Page
    func goToFirstPage(){
        if let window = GetWindow(), let vc = R.storyboard.auth.getStartedViewController() {
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        window.rootViewController = nav
        window.makeKeyAndVisible()
        }
    }
}


