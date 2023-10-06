//
//  HomeViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 12/05/21.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var sideMenuContainer: UIView!
    @IBOutlet weak var trailingContstraintOfSideMenu: NSLayoutConstraint!
    @IBOutlet weak var HorizontalScrollView: UIScrollView!
    @IBOutlet weak var ContainerView4: UIView!
    @IBOutlet weak var ContainerView3: UIView!
    @IBOutlet weak var ContainerView2: UIView!
    @IBOutlet weak var ContainerView1: UIView!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    //TOP
    @IBOutlet weak var topRightImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    //BOTTOM
    @IBOutlet weak var BottomOFBottomView: NSLayoutConstraint!
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var BottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewUnderShop: UIView!
    @IBOutlet weak var viewUnderProfiel: UIView!
    @IBOutlet weak var viewUnderGroup: UIView!
    @IBOutlet weak var ViewUnderHome: UIView!
    //SIDEMENU
    @IBOutlet weak var BlackView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var editImageView: UIView!
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var balckViewButton: UIButton!
    //language section
    @IBOutlet weak var languageSectionBlackView: UIView!
    @IBOutlet weak var languageCollectionView: UICollectionView!
    @IBOutlet weak var languageSectionWhiteView: UIView!
    
    //MARK:- CLASS VARIABLES AND CONSTANTS
    let SideMenuText = ["Dialect Level", "Daily Goal Parameter" , "Streak" , "Dialect Tokens", "Daily Goal","Chat"]
    var allLanguagesData = [UserLanguagesModelDataClass]()
    
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topRightImage.setupHexagonView()
        childsToContainerViews()
        NotificationCenter.default.addObserver(self, selector: #selector(SelectedLanguage(_:)), name: NSNotification.Name.init("LanguageSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GoPlay(_:)), name: NSNotification.Name.init("GoPlay"), object: nil)
        
      
    }

    @objc func SelectedLanguage(_ noti : Notification) {
        if let userInfo = noti.userInfo as? [String:String] {
            if let city = userInfo["language"] {
                apiCallForChangeUserLanguage(city)
            }
        }
    }
    
    @objc func GoPlay(_ noti : Notification) {
        if let userInfo = noti.userInfo as? [String:Int] {
            if let levelID = userInfo["id"] {
                if let vc = R.storyboard.initialTests.testProgressVC() {
                    vc.isFromGameLevel = true
                    vc.gameId = levelID
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
 
    //MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.trailingContstraintOfSideMenu.constant = UIScreen.main.bounds.width
        languageSectionSetup()
        setupViewForSideMenu()
        apiCallForGetUserLanguage()
     }
    
    
    //MARK:- LANGUAGE SECTION SETUP
    func languageSectionSetup(){
        self.languageSectionBlackView.isHidden = true
        self.languageSectionWhiteView.isHidden = true
        self.languageSectionWhiteView.roundViewCorner(radius: 10)
        self.languageSectionBlackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.languageSectionBlackView.makeClickable(target: self, selector: #selector(LanguageSectionBlackViewClicked))
    }
    
    //MARK:- LanguageSectionBlackViewClicked
    @objc func LanguageSectionBlackViewClicked(){
        self.languageSectionBlackView.isHidden = true
        self.languageSectionWhiteView.isHidden = true
    }
    
    //MARK:- ADD CHILDS TO CONTAINERS
    func childsToContainerViews(){
        
        if let vc = R.storyboard.home.homeLevelsViewController() {
            self.addChildView(viewControllerToAdd: vc, in: self.ContainerView1)
        }
        if let vc = R.storyboard.home.clubsViewController() {
            self.addChildView(viewControllerToAdd: vc, in: self.ContainerView2)
        }
        if let vc = R.storyboard.home.settingsViewController() {
            self.addChildView(viewControllerToAdd: vc, in: self.ContainerView3)
        }
        
        if let vc = R.storyboard.home.shopViewController() {
            self.addChildView(viewControllerToAdd: vc, in: self.ContainerView4)
        }
        
    }

    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        BottomOFBottomView.constant = 05 + self.view.safeAreaInsets.bottom
        BottomViewHeight.constant = self.view.safeAreaInsets.bottom + 60
        BottomView.giveShadowAndRoundCorners(shadowOffset: CGSize(width: 0, height: -5), shadowRadius: 5, opacity: 0.5, shadowColor: .lightGray, cornerRadius:0)
        stackViewWidth.constant = UIScreen.main.bounds.width * 4
        self.view.layoutIfNeeded()
    }
    
    
    //MARK:- BUTTON ACTIONS
    @IBAction func HomeButtonClicked(_ sender: Any) {
        topLabel.text = "Home"
        topRightImage.isHidden = false
        HorizontalScrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * 0, y: 0), animated: false)
        ViewUnderHome.backgroundColor = MainColor
        viewUnderGroup.backgroundColor = .clear
        viewUnderProfiel.backgroundColor = .clear
        viewUnderShop.backgroundColor = .clear
    }
    
    
    @IBAction func groupButtonClicked(_ sender: Any) {
        topLabel.text = "Clubs"
        topRightImage.isHidden = true
        HorizontalScrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * 1, y: 0), animated: false)
        ViewUnderHome.backgroundColor = .clear
        viewUnderGroup.backgroundColor = MainColor
        viewUnderProfiel.backgroundColor = .clear
        viewUnderShop.backgroundColor = .clear
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        topLabel.text = "Settings"
        topRightImage.isHidden = true
        HorizontalScrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * 2, y: 0), animated: false)
        ViewUnderHome.backgroundColor = .clear
        viewUnderGroup.backgroundColor = .clear
        viewUnderProfiel.backgroundColor = MainColor
        viewUnderShop.backgroundColor = .clear
    }
    
    @IBAction func shopButtonClicked(_ sender: Any) {
        topLabel.text = "Shop"
        topRightImage.isHidden = true
        HorizontalScrollView.setContentOffset(CGPoint(x: UIScreen.main.bounds.width * 3, y: 0), animated: false)
        ViewUnderHome.backgroundColor = .clear
        viewUnderGroup.backgroundColor = .clear
        viewUnderProfiel.backgroundColor = .clear
        viewUnderShop.backgroundColor = MainColor
    }
    
    //MARK:- SIDE MENU CLICKED
    
    @IBAction func SideMenuClicked(_ sender: Any) {
        self.trailingContstraintOfSideMenu.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.BlackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            }
        }
    }
    
    //MARK:- TOP RIGHT BUTTON
    
    @IBAction func topRightButtonOnHomePage(_ sender: Any) {
        self.languageSectionBlackView.isHidden = false
        self.languageSectionWhiteView.isHidden = false
        apiCallForGetUserLanguage()
    }
    
    
    //MARK:- BUTTON ON SIDE MENU
    
    @IBAction func EditButtonOnProfileImage(_ sender: Any) {
        MediaPicker.shared.showAttachmentActionSheet(vc: self)
        MediaPicker.shared.imagePickedBlock = { image in
            self.personImageView.image = image
            let param = ["email": UserDefaults.standard.string(forKey: UD_EMAIL) ?? "" , "name" : UserDefaults.standard.string(forKey: UD_NAME) ?? ""] as [String: Any]
            self.apicallForupdateProfile(dict: param, image: image)
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        apiCallForLogout()
    }
    
    @IBAction func inviteAFriendClicked(_ sender: Any) {
        
    }
    
    @IBAction func closeSideMenu(_ sender: Any) {
        self.trailingContstraintOfSideMenu.constant = UIScreen.main.bounds.width
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.BlackView.backgroundColor = .clear

        }
    }
    
  
    
}


