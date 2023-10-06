//
//  FindAClubVC.swift
//  Dialekt
//
//  Created by Vikas saini on 18/05/21.
//

import UIKit

class FindAClubVC: UIViewController {
    
    
    //MARK:- OUTLETS
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    //MARK:- CLASS VARIABLES AND CONSTANT
    var allClubs =  [AllClubListingDataClass]()
    var isSearched = false
    var searchedClubs = [AllClubListingDataClass]()
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tfSearch.delegate = self
        tfSearch.addTarget(self, action: #selector(TextIsChanging(_:)), for: UIControl.Event.editingChanged)
    }
    
    //MARK:- SETUP COLLECTION VIEW
    func setupCollectionView(){
        CollectionView.register(UINib(nibName: R.reuseIdentifier.findClubCVC.identifier, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.findClubCVC.identifier)
        CollectionView.delegate = self
        CollectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        CollectionView.dataSource = self
        CollectionView.reloadData()
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchView.giveShadowAndRoundCorners(shadowOffset: .zero, shadowRadius: 5, opacity: 0.7, shadowColor: .lightGray, cornerRadius: self.searchView.bounds.height / 2)
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.view.layoutIfNeeded()
    }
    
    
    //MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiCallForAllClubListing()
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func GoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func TextIsChanging(_ tf : UITextField){
        
        searchedClubs = tf.text!.isEmpty ? allClubs : (allClubs.filter { ($0.clubName?.range(of: tf.text! , options: [.caseInsensitive]) != nil ) })
        if tf.text == "" {
            isSearched = false
        }
        
        if searchedClubs.count>0 {
            isSearched = true
        }else{
            isSearched  = true
        }
        
        DispatchQueue.main.async {
            self.setupCollectionView()
        }
    }
    
}

extension FindAClubVC : UITextFieldDelegate {
    
    //MARK:- TEXTFIELD SHOULD RETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

