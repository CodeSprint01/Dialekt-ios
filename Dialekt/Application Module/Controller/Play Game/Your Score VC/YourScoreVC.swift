//
//  YourScoreVC.swift
//  Dialekt
//
//  Created by Techwin on 01/07/21.
//

import UIKit

class YourScoreVC: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var exitbutton: UIButton!
    @IBOutlet weak var viewScoreBoardButton: UIButton!
    @IBOutlet weak var PlayAgainButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var FinalScore = ""
    var groupID = ""
    var gameID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        scoreLabel.text = "Your Score : \(FinalScore)"
    }
    
    
    func setupUI(){
        backButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        viewScoreBoardButton.roundViewCorner(radius: 08)
        whiteView.roundViewCorner(radius: 20)
    }


    @IBAction func TappedDismiss(_ sender: Any) {
        //do Nothing
    }
    
    @IBAction func PlayAgainButton(_ sender: Any) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name.init("PlayAgain"), object: nil, userInfo: nil)
        }
    }
    
    @IBAction func ViewScoreboardTapped(_ sender: Any) {
        if let vc = R.storyboard.playGame.scoreboardViewController() {
            vc.modalPresentationStyle = .overFullScreen
            vc.groupID = self.groupID
            vc.gameID = self.gameID
            self.present(vc, animated: true, completion: nil)
        }
//        Toast.show(message: "Under Developement", controller: self)
    }
    
    @IBAction func exitButtonTapped(_ sender: Any) {
        if let window = GetWindow(), let vc = R.storyboard.home.homeViewController() {
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}
}
