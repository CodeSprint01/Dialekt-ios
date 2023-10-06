//
//  DialektTokenVCFromSideMenu.swift
//  Dialekt
//
//  Created by Vikas saini on 17/05/21.
//

import UIKit

class DialektTokenVCFromSideMenu: UIViewController {

    
    //MARK:- OUTLETS
  
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var continueButton: UIButton!
   
    //MARK:- view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hiding this View Currently, because its significance is unknow
        //===
        continueButton.isHidden = true
        //===
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.continueButton.giveShadow()
        self.view.layoutIfNeeded()
    }
    
    
    //MARK:- BUTTON ACTIONS
    @IBAction func continueButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func GoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
