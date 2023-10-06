//
//  LevelResultVC.swift
//  Dialekt
//
//  Created by Techwin on 03/08/21.
//

import UIKit

class LevelResultVC: UIViewController {

    @IBOutlet weak var ContinueButton: UIButton!
    @IBOutlet weak var LevelPointsView: UIView!
    @IBOutlet weak var labelForLevelPoints: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    //MARK:- CLASS VARIABLES AND CONSTANT
    var GameID = 0
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        LevelPointsView.roundViewCorner(radius: 06)
        ContinueButton.roundViewCorner(radius: 06)
        LevelPointsView.layer.borderWidth = 1
        LevelPointsView.layer.borderColor = MainColor.cgColor
        apiCallForLevelComplete()
    }
    
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
    }
    
    
    @IBAction func ContinueButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func GoBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
