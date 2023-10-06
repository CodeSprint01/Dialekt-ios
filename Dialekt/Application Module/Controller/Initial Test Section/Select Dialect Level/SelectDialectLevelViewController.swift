//
//  SelectDialectLevelViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 10/05/21.
//

import UIKit

class SelectDialectLevelViewController: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var BeginerButton: UIButton!
    @IBOutlet weak var intermediateButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var expertButton: UIButton!
    
    
    //MARK:CLASS CONTANTS AND VARIABLES
    var LightGrayColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    var selectedCity = ""
    var selectedDailekt  = ""
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        for view in stackView.arrangedSubviews {
            view.giveShadow()
         }
       
    }
    
    
    //MARK:- BUTTON ACTIONS
    @IBAction func GoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func ExpertButtonPressed(_ sender: Any) {
        self.expertButton.backgroundColor = MainColor
        self.expertButton.setTitleColor(.white, for: .init())
        self.intermediateButton.backgroundColor = LightGrayColor
        self.intermediateButton.setTitleColor(.black, for: .init())
        self.BeginerButton.backgroundColor = LightGrayColor
        self.BeginerButton.setTitleColor(.black, for: .init())
//        GoForTest("3")
        if let vc = R.storyboard.initialTests.quizVC(){
            vc.selectedCity = self.selectedCity
            vc.selectedLanguage = self.selectedDailekt
            vc.selectedLevel = "3"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func IntermediatePressed(_ sender: Any) {
        self.expertButton.backgroundColor = LightGrayColor
        self.expertButton.setTitleColor(.black, for: .init())
        self.intermediateButton.backgroundColor = MainColor
        self.intermediateButton.setTitleColor(.white, for: .init())
        self.BeginerButton.backgroundColor = LightGrayColor
        self.BeginerButton.setTitleColor(.black, for: .init())
        if let vc = R.storyboard.initialTests.quizVC(){
            vc.selectedCity = self.selectedCity
            vc.selectedLanguage = self.selectedDailekt
            vc.selectedLevel = "2"
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        GoForTest("2")
    }
    
    @IBAction func beginerPressed(_ sender: Any) {
        self.expertButton.backgroundColor = LightGrayColor
        self.expertButton.setTitleColor(.black, for: .init())
        self.intermediateButton.backgroundColor = LightGrayColor
        self.intermediateButton.setTitleColor(.black, for: .init())
        self.BeginerButton.backgroundColor = MainColor
        self.BeginerButton.setTitleColor(.white, for: .init())
// GoForTest("1")
        
        if let vc = R.storyboard.initialTests.quizVC(){
            vc.selectedCity = self.selectedCity
            vc.selectedLanguage = self.selectedDailekt
            vc.selectedLevel = "1"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
//MARK:- GO TO NEXT PAGE
    func GoForTest(_ strLevel :String){
        if let vc = R.storyboard.initialTests.takeInitialTestVC(){
            vc.selectedCity = self.selectedCity
            vc.selectedLanguage = self.selectedDailekt
            vc.selectedLevel = strLevel
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
