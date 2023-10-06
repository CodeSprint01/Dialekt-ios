//
//  SelectCityViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 09/05/21.
//

import UIKit

class SelectCityViewController: UIViewController {

    //MARK:- OUTLETS
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var CollectionView: UICollectionView!
   
    
    //MARK:- CLASS VARIABLES AND CONSTANT
    var selectedIndex = 123456 // the value will be updated in didSelectItemAt
    var allCitiesData = [ParticularCityData]()
    var total_pages = 1
    var current_page = 1
    var isFromSignUp = false
    var isFromSocialLogin = false
    var socailLoggedInUserDetail : LoginModelDataClass?// when isFromSocailLogin
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tfSearch.delegate = self
        CollectionView.register(UINib(nibName: R.reuseIdentifier.selectCityCVC.identifier, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.selectCityCVC.identifier)
        tfSearch.addTarget(self, action: #selector(TextIsChanging), for: .editingChanged)
        apiCallForCityList(search: "", Page: 1 , true)
    }
    
    //MARK:- TEXT IS CHANGING
    @objc func TextIsChanging(_ tf : UITextField) {
        apiCallForCityList(search: tf.text?.trimmed() ?? "", Page: 1)
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchView.giveShadowAndRoundCorners(shadowOffset: .zero, shadowRadius: 5, opacity: 0.7, shadowColor: .lightGray, cornerRadius: self.searchView.bounds.height / 2)
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
       
    }
    
    
    //MARK:- BUTTON ACTIONS
    
    @IBAction func GoBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   

}

extension SelectCityViewController : UITextFieldDelegate {

    //MARK:- TEXTFIELD SHOULD RETURN
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



extension SelectCityViewController {
    
    //MARK:- SCROLL VIEW DID END DECELERATING
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
          print("scrollViewDidEndDecelerating")
          guard total_pages != 1 else {return}
          let remainingPagesCount = total_pages - current_page
          print("remainingPagesCount", remainingPagesCount)
          _ = scrollView.contentOffset.y
          let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
          if scrollView == CollectionView{
              if (scrollView.contentOffset.y == /*0*/ maximumOffset) {
                  if remainingPagesCount < 1{}else{
                    let pageNo = current_page + 1
                    apiCallForCityList(search: tfSearch.text?.trimmed() ?? "", Page: pageNo)
                  }
              }
          }
      }
}
