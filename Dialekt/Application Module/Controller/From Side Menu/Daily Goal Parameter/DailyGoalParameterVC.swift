//
//  DailyGoalParameterVC.swift
//  Dialekt
//
//  Created by Vikas saini on 17/05/21.
//

import UIKit

class DailyGoalParameterVC: UIViewController {
    
    //MARK:- OUTLETS

    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- CLASS VARIABLES AND CONSTANTS
    var selectedIndex = -1
    var FirstArray = ["Causal" , "Regular" , "Serious" , "Insane"]
    var SecondArray = ["5", "10" , "15", "20"]
        
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = (UserDefaults.standard.string(forKey: UD_DAILYGOAL)?.toInt() ?? -2) - 1
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.reuseIdentifier.dailyGoalsTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.dailyGoalsTVC.identifier)
        tableView.separatorStyle = .none
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.view.layoutIfNeeded()
    }

    //MARK:- BUTTON ACTIONS
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
