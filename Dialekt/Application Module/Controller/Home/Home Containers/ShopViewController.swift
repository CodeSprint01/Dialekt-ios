//
//  ShopViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 12/05/21.
//

import UIKit

class ShopViewController: UIViewController {

    @IBOutlet weak var toalNumberLabel: UILabel!
    @IBOutlet weak var ViewButton: UIButton!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstView: UIView!
   
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstView.giveShadow()
        secondView.giveShadow()
        ViewButton.roundButtonCorner(radius: 5)
    }
    
    
    //MARK:- VIEW TOKEN BUTTON ACTION
    @IBAction func ViewTokensButtonAction(_ sender: Any) {
        if let vc = R.storyboard.fromShop.totalDailektToakensVC() {
            self.parent?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK:- LIST BUTTON ACTION
    @IBAction func listItemButtonClicked(_ sender: Any) {
        if let vc = R.storyboard.fromShop.shopVC() {
            self.parent?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}
