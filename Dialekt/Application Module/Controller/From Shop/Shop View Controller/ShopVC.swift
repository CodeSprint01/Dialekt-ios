//
//  ShopVC.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import UIKit

class ShopVC: UIViewController {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    //MARK: - VARIABLES AND CLASS CONSTANTS
    var shopItems = [ListShopItemsModelDataClass]()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCallForShopItemListing()
    }
    
    //MARK: - SETUP COLLECTION
    func setupCollection(){
        CollectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 20, right: 0)
        CollectionView.delegate = self
        CollectionView.register(UINib(nibName: R.reuseIdentifier.shopCVC.identifier, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.shopCVC.identifier)
        CollectionView.dataSource = self
    }
    
    //MARK: - VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.view.layoutIfNeeded()
    }
    
    //MARK: - GO BACK
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
