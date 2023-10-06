//
//  ShopCVC.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import UIKit
import SDWebImage

class ShopCVC: UICollectionViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var shopNowButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.amountView.roundViewCorner(radius: 14)
            self.shopNowButton.roundViewCorner(radius: 14)
            //self.backView.giveShadow()
        }
    }
    
    func setupCell(_ item : ListShopItemsModelDataClass?){
        amountLabel.text = item?.point ?? "0"
        itemNameLabel.text = item?.name ?? "-"
        self.itemImageView.sd_setImage(with: URL(string: UPDATED_IMAGE_BASE_URL + (item?.image ?? "")), placeholderImage: #imageLiteral(resourceName: "diamondImage"), options: [.highPriority], context: nil)
    }
}
