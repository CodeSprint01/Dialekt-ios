//
//  CreateClubVC.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import UIKit

class CreateClubVC: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var tfDescription: UITextField!
    @IBOutlet weak var tfClubName: UITextField!
    
    //MARK:- CONSTANTS AND VARIABLE
    var selectedIndexes = [Int]()
    var allUsers = [LoginModelDataClass]()
    var total_pages = 1
    var current_page = 1
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCallForUserList(search: "", Page: 1, true)
        tfSearch.delegate = self
        tfDescription.delegate = self
        tfClubName.delegate = self
        setupTableView()
        tfSearch.addTarget(self, action: #selector(TextIsChanging), for: .editingChanged)

    }
    
    //MARK:- TEXT IS CHANGING
    @objc func TextIsChanging(_ tf : UITextField) {
        apiCallForUserList(search: tf.text?.trimmed() ?? "", Page: 1)
    }
    
    //MARK:- SETUP TABLE VIEW
    func setupTableView(){
        self.tableView.register(UINib(nibName: R.reuseIdentifier.createClubTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.createClubTVC.identifier)
    }
    
    
    
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        personImage.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        personImage.layer.borderWidth = 1
        personImage.roundImgCorner(radius: self.personImage.bounds.width / 2)
//        personImage.giveShadow(self.personImage.bounds.height / 2)
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.view.layoutIfNeeded()
    }
    
  
    //MARK:- BUTTON ACTIONS
    @IBAction func cameraButton(_ sender: Any) {
        MediaPicker.shared.showAttachmentActionSheet(vc: self)
        MediaPicker.shared.imagePickedBlock = { image in
            self.cameraImage.image = nil
            self.personImage.image = image
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        let clubName = tfClubName.text?.trimmed() ?? ""
        let clubDescription = tfDescription.text?.trimmed() ?? ""
        let userIDs = selectedIndexes.map({String($0)}).joined(separator: ",")
        guard personImage.image != nil else {
            Toast.show(message: "Please add a club Image..", controller: self)
            return
        }
        if clubName != "" {
            let dict = [ "club_name":clubName,
                         "description":clubDescription,
//                         "user_id": "\(userIDs)"
                         "user_id": userIDs 
            ] as [String:Any]
            
            print("dict = \(dict)")
            
            apiCallForCreateClub(dict)
        }else {
            Toast.show(message: "Enter a club name...", controller: self)
        }
    }
    
    
}




extension CreateClubVC : UITextFieldDelegate {
    
    //MARK:- TEXTFIELD SHOULD RETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfSearch {
            textField.resignFirstResponder()
        }else if textField == tfClubName {
            tfDescription.becomeFirstResponder()
        }else {
            tfSearch.becomeFirstResponder()
        }
        return true
    }
}


extension CreateClubVC {
    
    //MARK:- SCROLL VIEW DID END DECELERATING
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
          guard scrollView == tableView else {return}
          guard total_pages != 1 else {return}
          let remainingPagesCount = total_pages - current_page
          print("remainingPagesCount", remainingPagesCount)
          _ = scrollView.contentOffset.y
          let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
          if scrollView == tableView{
              if (scrollView.contentOffset.y == /*0*/ maximumOffset) {
                  if remainingPagesCount < 1{
            
                  }else{
                    let pageNo = current_page + 1
                    apiCallForUserList(search: tfSearch.text?.trimmed() ?? "", Page: pageNo)
                  }
              }
          }
      }
}
