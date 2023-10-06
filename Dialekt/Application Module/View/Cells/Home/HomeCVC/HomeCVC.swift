//
//  HomeCVC.swift
//  Dialekt
//
//  Created by Vikas saini on 10/05/21.
//

import UIKit

class HomeCVC: UICollectionViewCell {

    @IBOutlet weak var viewForShadow: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var tickView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.outerView.backgroundColor = .white
            self.viewForShadow.giveShadowAndRoundCorners(shadowOffset: .zero, shadowRadius: 30, opacity: 0.8, shadowColor: .lightGray, cornerRadius:  self.viewForShadow.bounds.height/2)
            self.outerView.setupHexagonView(12)
            self.innerView.setupHexagonView(12)
            self.tickView.giveShadow(self.tickView.bounds.height / 2)
        }
    }

}
