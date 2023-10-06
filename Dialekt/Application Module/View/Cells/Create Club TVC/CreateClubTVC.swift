//
//  CreateClubTVC.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import UIKit
import SDWebImage

class CreateClubTVC: UITableViewCell {

    @IBOutlet weak var tickImage: UIImageView!
    @IBOutlet weak var tickView: UIView!
    @IBOutlet weak var personEmailLabel: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.tickView.roundViewCorner(radius: self.tickView.bounds.height / 2)
            self.personImage.roundViewCorner(radius: self.personImage.bounds.height / 2)
            self.tickView.layer.borderColor = MainColor.cgColor
            self.tickView.layer.borderWidth = 1
        }
    }
    
    func setupCell(_ user : GroupWiseUserListingDataClass) {
        self.personImage.sd_setImage(with: URL(string: IMAGE_BASE_URL + (user.image ?? "")), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
        self.personImage.tintColor = .darkGray
        self.personNameLabel.text = user.name ?? "--"
        self.personEmailLabel.text = user.email ?? "--"
    }

    
    
    func setupCell(_ user : LoginModelDataClass) {
        self.personImage.sd_setImage(with: URL(string: IMAGE_BASE_URL + (user.image ?? "")), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
        self.personImage.tintColor = .darkGray
        self.personNameLabel.text = user.name ?? "--"
        self.personEmailLabel.text = user.email ?? "--"
    }
    
}
