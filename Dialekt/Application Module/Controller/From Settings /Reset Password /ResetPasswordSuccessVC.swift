//
//  ResetPasswordSuccessVC.swift
//  Dialekt
//
//  Created by Vikas saini on 13/05/21.
//

import UIKit

class ResetPasswordSuccessVC: UIViewController {

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
        self.view.layoutIfNeeded()
    }

    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
