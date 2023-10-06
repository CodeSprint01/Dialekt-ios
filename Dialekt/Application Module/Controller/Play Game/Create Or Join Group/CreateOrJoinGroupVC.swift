//
//  CreateOrJoinGroupVC.swift
//  Dialekt
//
//  Created by Techwin on 30/06/21.
//

import UIKit

class CreateOrJoinGroupVC: UIViewController {

    //MARK:- OUTLETS
    
    @IBOutlet weak var NumberOfUserSelectedLabel: UILabel!
    @IBOutlet weak var tfEnterGroupJoiningCode: UITextField!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tfCreateGroupCode: UITextField!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var createGroupLabel: UILabel!
    @IBOutlet weak var CreateGroupView: UIView!
    @IBOutlet weak var EnterGroupLabel: UILabel!
    @IBOutlet weak var joinGameButton: UIButton!
    @IBOutlet weak var EnterGroupView: UIView!
    
    //MARK:- CONSTANTS AND VARIABLES
    var CreatedGroupCode : String?
    var selectedUserIds = [Int]()
    
    //MARK:- VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(selectedUsers), name: .init("selectedUsers"), object: nil)
    }
    
    
    //MARK: - SELECTED USERS FOR JOIN
     @objc func selectedUsers(_ noti : Notification) {
        if let userinfo = noti.userInfo as? [String:[Int]] {
            if let ids = userinfo["ids"]{
                selectedUserIds = ids
                self.NumberOfUserSelectedLabel.text = "\(self.selectedUserIds.count)"
            }
        }
     }
    
    //MARK:- SETUP UI
    func setupUI(){
        CreateGroupView.giveShadow(20, .zero)
        tfCreateGroupCode.giveShadow(self.tfCreateGroupCode.bounds.height / 2, .zero)
        createGroupLabel.roundViewCorner(radius: 05)
        startGameButton.roundViewCorner(radius: 05)
        EnterGroupLabel.roundViewCorner(radius: 05)
        tfEnterGroupJoiningCode.giveShadow(self.tfEnterGroupJoiningCode.bounds.height  / 2, .zero)
        joinGameButton.roundViewCorner(radius: 05)
        EnterGroupView.giveShadow(20 ,.zero)
        joinGameButton.addTarget(self, action: #selector(JoinGameTapped), for: .touchUpInside)
        startGameButton.addTarget(self, action: #selector(StartGameTapped), for: UIControl.Event.touchUpInside)
        
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
    }
    
    
    //MARK:- GO BACK
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- JOIN GAME TAPPED
    @objc func JoinGameTapped(){

        let text = tfEnterGroupJoiningCode.text?.trimmed() ?? ""
        if text != "" {
           apiCallForJoinGroup()
        }else {
            Toast.show(message: "Enter Group Joining Code first!", controller: self)
        }
      
    }
    
    //MARK:- SHARE GROUP CODE TAPED
    @IBAction func shareGroupCodeTaped(_ sender: Any) {
//        if self.CreatedGroupCode != nil {
            if let vc = R.storyboard.playGame.allUsersVC() {
                self.present(vc, animated: true, completion: nil)
            }
//        }else {
//            Toast.show(message: "Create a group First!", controller: self)
//        }
    }
    
    //MARK:- START GAME TAPPED
    @objc func StartGameTapped(){
        let text = tfCreateGroupCode.text?.trimmed() ?? ""
        if selectedUserIds.count != 0 {
        if text != "" {
            apiCallForCreateGroup()
        }else {
            Toast.show(message: "Enter Group Code first!", controller: self)
        }
        }else{
            Toast.show(message: "Select atleast one user.", controller: self)
        }
    }
}
