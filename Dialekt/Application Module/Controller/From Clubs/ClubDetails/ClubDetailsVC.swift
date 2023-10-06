//
//  ClubDetailsVC.swift
//  Dialekt
//
//  Created by iApp on 24/08/22.
//

import UIKit

class ClubDetailsVC: UIViewController {
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editPhotoBtn: UIButton!
    @IBOutlet weak var clubNameLbl: UILabel!
    @IBOutlet weak var clubCreatorNameLbl: UILabel!
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var participantsListTableView: UITableView!
    @IBOutlet weak var exitBtn: UIButton!
    
    var clubModel: AllClubListingDataClass?
    var clubDetails: ClubDetails? = nil
    
    //MARK: - LIFE CYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        clubNameLbl.text = clubModel?.clubName
//        clubCreatorNameLbl.text = clubModel?.adminName
        profileImageView.sd_setImage(with: URL(string: clubModel?.image ?? ""), placeholderImage: UIImage(named: "clubPlaceholder"), options: [.highPriority], context: nil)
        
        self.apiGetClubDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        profileImageView.giveShadowAndRoundCorners(shadowOffset: CGSize(width: -1, height: 7), shadowRadius: 8, opacity: 0.1, shadowColor: .white, cornerRadius: profileImageView.frame.height/2)
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 2.5
        profileImageView.clipsToBounds = true
        
        editPhotoBtn.giveShadowAndRoundCorners(shadowOffset: CGSize(width: -1, height: 7), shadowRadius: 8, opacity: 0.1, shadowColor: .white, cornerRadius: editPhotoBtn.frame.height/2)
        editPhotoBtn.layer.borderColor = UIColor.white.cgColor
        editPhotoBtn.layer.borderWidth = 1.2
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            self.topView.addBottomRoundedEdge(desiredCurve: 1.5)
            
        }
    }
    
    //MARK: - METHODS
    
    func registerCell() {
        participantsListTableView.dataSource = self
        participantsListTableView.delegate = self
        participantsListTableView.register(UINib(nibName: "ClubDetailsParticipantsTVCell", bundle: nil), forCellReuseIdentifier: "ClubDetailsParticipantsTVCell")
    }
    
    func updateData() {
        clubNameLbl.text = clubDetails?.clubName
        clubCreatorNameLbl.text = clubDetails?.adminName
        profileImageView.sd_setImage(with: URL(string: clubDetails?.image ?? ""), placeholderImage: UIImage(named: "clubPlaceholder"), options: [.highPriority], context: nil)
        participantsListTableView.reloadData()

        guard let clubDetails = clubDetails else {
            return
        }

        
        if clubDetails.isJoined {
            exitBtn.isEnabled =  true
            exitBtn.isEnabled =  true
            joinBtn.setTitle( "Joined", for: .normal)
            let bgColor = 238.0/255.0
            joinBtn.backgroundColor = UIColor.init(red: bgColor, green: bgColor, blue: bgColor, alpha: 1.0)
            let txtColor = 64.0/255.0
            joinBtn.setTitleColor(UIColor.init(red: txtColor, green: txtColor, blue: txtColor, alpha: 1.0), for: .normal)
        } else {
            exitBtn.isEnabled =  false
            exitBtn.isEnabled =  false
            joinBtn.setTitle( "Join Club", for: .normal)
            joinBtn.backgroundColor = UIColor(named: "MainColor")
            joinBtn.setTitleColor(.white, for: .normal)
        }
        editPhotoBtn.isHidden = clubDetails.isCreater ? false : true
    }
    
    //MARK: - ACTIONS
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editPhotoBtnAction(_ sender: UIButton) {
        
        MediaPicker.shared.showAttachmentActionSheet(vc: self)
        MediaPicker.shared.imagePickedBlock = { [weak self] image in
            guard let self = self else {return}
            guard let clubID = self.clubModel?.clubID else {return}
            self.apiUpdateClubImage(clubID: clubID, image: image)
        }
    }
 
    @IBAction func joinBtnAction(_ sender: UIButton) {
        guard let clubCode = clubModel?.clubCode else {return}
        self.apiCallForJoinClub("\(clubCode)") { [weak self] in
            self?.apiGetClubDetails()
        }
    }
    
    @IBAction func exitClubBtnAction(_ sender: UIButton) {
        guard let clubCode = clubModel?.clubCode else {return}
        self.apiCallForJoinClub("\(clubCode)") { [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

