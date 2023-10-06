//
//  SelectCityCVC.swift
//  Dialekt
//
//  Created by Vikas saini on 09/05/21.
//

import UIKit

class SelectCityCVC: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var backView: UIView!
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.backView.giveShadow()
            self.imageview.roundImgCorner(radius: self.imageview.bounds.height / 2)
        }
    }

}
