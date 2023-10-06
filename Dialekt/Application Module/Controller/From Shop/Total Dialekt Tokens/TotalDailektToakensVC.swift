//
//  TotalDailektToakensVC.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import UIKit

class TotalDailektToakensVC: UIViewController {

    
    //MARK:- OUTLETS
    
    @IBOutlet weak var NumberOFPointsLabel: UILabel!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
  
    
    //MARK:- VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
      //  middleView.giveShadow()
        self.view.layoutIfNeeded()
    }
    
    //  MARK:- GO BACK
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
}
