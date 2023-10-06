//
//  JoiningCodePopupVC.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import UIKit

class JoiningCodePopupVC: UIViewController {

    
    //MARK:- OUTLETS
    
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var joinCodeButton: UIButton!
    @IBOutlet weak var tfJoiningCode: UITextField!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var clubImage: UIImageView!
   
    
    //MARK:- VIEW DID LOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        whiteView.roundViewCorner(radius: 10)
        clubImage.layer.borderWidth = 4
        clubImage.layer.borderColor = UIColor.white.cgColor
        clubImage.giveShadow(clubImage.bounds.height / 2)
        clubImage.clipsToBounds = true
        clubImage.contentMode = .scaleAspectFill
        tfJoiningCode.backgroundColor = .white
        tfJoiningCode.setLeftPaddingPoints(20)
        tfJoiningCode.setRightPaddingPoints(20)
        joinCodeButton.giveShadow()
        DispatchQueue.main.async {
      
            self.tfJoiningCode.giveShadow(self.tfJoiningCode.bounds.height / 2)
        }
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blackView.makeClickable(target: self, selector: #selector(CancelOnTouchOutside))
        joinCodeButton.addTarget(self, action: #selector(joinClubButtonPressed), for: UIControl.Event.touchUpInside)
        
    }
    
    
    //MARK:- SELECTOR METHOD
    
    @objc func CancelOnTouchOutside() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func joinClubButtonPressed(){
        let joiningCode = tfJoiningCode.text?.trimmed() ?? ""
        if joiningCode != "" {
            apiCallForJoinClub(joiningCode)
        }
    }

   

}
