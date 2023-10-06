//
//  AllUsersVC.swift
//  Dialekt
//
//  Created by Techwin on 06/07/21.
//

import UIKit

class AllUsersVC: UIViewController , UITextFieldDelegate{

    
    //MARK:- OUTLETS
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- CONSTANTS AND VARIABLE
    var selectedIndexes = [Int]()
    var allUsers = [GroupWiseUserListingDataClass]()
//    var total_pages = 1
//    var current_page = 1
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tfSearch.delegate = self
        tfSearch.addTarget(self, action: #selector(TextIsChanging), for: .editingChanged)
        self.setupTableView()
        self.apiCallForUserList(search: "")//, Page: 1)
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
    }
    
    //MARK:- TEXT IS CHANGING
    @objc func TextIsChanging(_ tf : UITextField) {
        apiCallForUserList(search: tf.text?.trimmed() ?? "")//, Page: 1)
    }
    
    //MARK:- BUTTON ACTION
    @IBAction func ShareButtonTapped(_ sender: Any) {
        if selectedIndexes.count > 0 {
            //Users Selected, Ready for api call
            NotificationCenter.default.post(name: NSNotification.Name.init("selectedUsers"), object: nil, userInfo: ["ids" : selectedIndexes])
            self.dismiss(animated: true, completion: nil)
        }else {
            Toast.show(message: "Select at least one user.", controller: self)
        }
    }
    
    
    @IBAction func CloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
