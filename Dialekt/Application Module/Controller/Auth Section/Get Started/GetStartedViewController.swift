//
//  GetStartedViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 06/05/21.
//

import UIKit
import Lottie

class GetStartedViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    //MARK:- OUTLETS
    @IBOutlet weak var AlreadyHaveAnAccountButton: UIButton!
    @IBOutlet weak var GetStartedButton: UIButton!

    //MARK:- VIEW DID LOAD
     override func viewDidLoad() {
        super.viewDidLoad()
        AlreadyHaveAnAccountButton.roundButtonCorner(radius: 8)
        GetStartedButton.roundButtonCorner(radius: 8)
        AlreadyHaveAnAccountButton.GiveBorder(width: 1.0, color: MainColor)
         let animation = Animation.named("Welcome")
         animationView.animation = animation
         animationView.loopMode = .loop
         animationView.contentMode = .scaleAspectFit
         animationView.play()
        
    }
    

    //MARK:- BUTTON ACTIONS
    
    @IBAction func getStartedClicked(_ sender: Any) {
        if let vc = R.storyboard.initialTests.selectCityViewController(){
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    @IBAction func alreadyHaveAnAccountClicked(_ sender: Any) {
        if let vc = R.storyboard.auth.loginViewController(){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

