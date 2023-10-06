//
//  JoinedClubsVC.swift
//  Dialekt
//
//  Created by Vikas saini on 18/05/21.
//

import UIKit

class JoinedClubsVC: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var numberOfClubsLabel: UILabel!
    
    //MARK:- CONSTANTS AND VARIABLES
    var myAllClubsArray = [MyClubsModelDataClass]()
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfClubsLabel.text = ""
        setupTableView()
        
    }
    
    //MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiCallForGettingAllMyClubs()
    }
    
    //MARK:- TABLE VIEW SETUP
    func setupTableView(){
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: R.reuseIdentifier.joinedClubsTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.joinedClubsTVC.identifier)
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.view.layoutIfNeeded()
    }
    
    
    //MARK:- GO BACK
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
