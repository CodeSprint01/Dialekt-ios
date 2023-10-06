//
//  ClubsViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 12/05/21.
//

import UIKit

class ClubsViewController: UIViewController {

    //MARK:- OUTLETS
    
    @IBOutlet weak var secondlabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var centerImageView: UIImageView!
    @IBOutlet weak var FindClubButton: UIButton!
    @IBOutlet weak var createClubButton: UIButton!
    @IBOutlet weak var joinedclub: UIButton!
    

    //MARK:- CLASS VARIABLES
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(showJoined), name: Notification.Name.init("showJoined"), object: nil)//THIS NOTIFICATION WILL BE OBSERVED WHEN USER JOIN A CLUB FROM JOINING CODE.
    }
    
    //MARK:- SHOW CLUB JOINED TOAST
    @objc func showJoined(){
        Toast.show(message: "Club Joined.", controller: self)
    }
    
    //MARK:- SETUP VIEW
    func setupView() {
        FindClubButton.roundButtonCorner(radius: 5)
        joinedclub.roundButtonCorner(radius: 5)
        createClubButton.roundButtonCorner(radius: 5)
        joinedclub.GiveBorder(width: 1, color: MainColor)
        createClubButton.GiveBorder(width: 1, color: MainColor)
        centerImageView.makeClickable(target: self, selector: #selector(clickedonImage))
    }
    
    @objc func clickedonImage() {
        
        if let vc = R.storyboard.fromClubs.joiningCodePopupVC() {
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.parent?.present(vc, animated: true, completion: nil)
        }
    }

    
    //MARK:- BUTTON ACTIONS
    
    @IBAction func createClubAction(_ sender: Any) {
        if let vc = R.storyboard.fromClubs.createClubVC() {
            self.parent?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func joinedclubActin(_ sender: Any) {
        if let vc = R.storyboard.fromClubs.joinedClubsVC() {
            self.parent?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func FindAClubButtonAction(_ sender: Any) {
        if let vc = R.storyboard.fromClubs.findAClubVC() {
            self.parent?.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
