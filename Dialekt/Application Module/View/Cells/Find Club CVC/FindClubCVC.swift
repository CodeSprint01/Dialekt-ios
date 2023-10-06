//
//  FindClubCVC.swift
//  Dialekt
//
//  Created by Vikas saini on 18/05/21.
//

import UIKit
import SDWebImage

class FindClubCVC: UICollectionViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.backView.giveShadow()
            self.clubImage.roundCorners(corners: [.topLeft , .topRight], radius: 08)
            self.joinButton.roundViewCorner(radius: 5)
            for img in self.stackView.arrangedSubviews {
                img.roundViewCorner(radius: img.bounds.height / 2)
                img.layer.borderWidth = 1
                img.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            }
        }
    }
    
    //MARK:- SETUP THIS CELL
    
    func setupCell(_ data : AllClubListingDataClass){
        self.clubImage.sd_setImage(with: URL(string: IMAGE_BASE_URL + (data.image ?? "")), placeholderImage: #imageLiteral(resourceName: "city"), options: [.highPriority], context: nil)
        self.nameLabel.text = data.clubName ?? "--"
        for a in stackView.arrangedSubviews {
            a.isHidden = true
        }
        if data.user?.count ?? 0 > 0 {
            for i in 0...data.user!.count-1 {
                (stackView.arrangedSubviews[i] as! UIImageView).isHidden = false
                (stackView.arrangedSubviews[i] as! UIImageView).tintColor = .darkGray
                (stackView.arrangedSubviews[i] as! UIImageView).sd_setImage(with: URL(string: IMAGE_BASE_URL + (data.user?[i].image ?? "")), placeholderImage: #imageLiteral(resourceName: "profile"), options: [.highPriority], context: nil)
            }
        }
    }

}
