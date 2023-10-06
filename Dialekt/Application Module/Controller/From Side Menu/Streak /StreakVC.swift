//
//  StreakVC.swift
//  Dialekt
//
//  Created by Vikas saini on 17/05/21.
//

import UIKit
import FSCalendar

class StreakVC: UIViewController {

    //MARK:- OUTLET
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var CalendarView: FSCalendar!
    @IBOutlet weak var labelINMiddel: UILabel!
    
    
//    var allStreaks = [DailyStreakModelDataClass]()
    var allDates = [Date]()
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelINMiddel.text = "0"
        CalendarView.scope  = .week
        apiCallForGettingStreak()
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.shareView.giveShadow()
        self.CalendarView.giveShadow()
        self.view.layoutIfNeeded()
    }
    
    //MARK:- BUTTON ACTIONS
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
