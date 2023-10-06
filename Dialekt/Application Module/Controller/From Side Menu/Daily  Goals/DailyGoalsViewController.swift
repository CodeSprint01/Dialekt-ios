//
//  DailyGoalsViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 17/05/21.
//

import UIKit

class DailyGoalsViewController: UIViewController {

    //MARK:- OUTLETS

    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var viewForShadow: UIView!
    @IBOutlet weak var editButton: UIButton!
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hiding this View Currently, because its significance is unknow
        //===
        editButton.isHidden = true
        //===
        
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
        self.topViewHeight.constant = self.view.safeAreaInsets.top + 75
        self.topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.editButton.giveShadow()
        self.outerView.setupHexagonView(15)
        self.innerView.setupHexagonView(15)
        self.viewForShadow.giveShadowAndRoundCorners(shadowOffset: .zero, shadowRadius: 30, opacity: 0.8, shadowColor: .lightGray, cornerRadius:self.viewForShadow.bounds.height/2)
        self.progressView.roundViewCorner(radius: 7.5)
        }
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func editButtonAction(_ sender: Any) {
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
