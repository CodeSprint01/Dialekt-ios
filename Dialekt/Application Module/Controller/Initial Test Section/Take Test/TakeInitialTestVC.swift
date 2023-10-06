//
//  TakeInitialTestVC.swift
//  Dialekt
//
//  Created by Vikas saini on 21/05/21.
//

import UIKit

class TakeInitialTestVC: UIViewController {

    
    //MARK:- OUTLETS
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var labelForText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedLanguage = ""
    var selectedCity = ""
    var selectedLevel = "1" // 1, 2, 3 in increasing order
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        labelForText.text = "Test your skills"
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        continueButton.giveShadow()
    }
    
    
    
    //MARK:- BUTTON ACTIONS

    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if let vc = R.storyboard.initialTests.testProgressVC(){
            vc.selectedLevel = self.selectedLevel
            vc.selectedCity = self.selectedCity
            vc.selectedLanguage = self.selectedLanguage
            self.navigationController?.pushViewController(vc, animated: true)
        }
     }
    
}
