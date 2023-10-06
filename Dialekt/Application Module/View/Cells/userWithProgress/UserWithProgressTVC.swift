//
//  UserWithProgressTVC.swift
//  Dialekt
//
//  Created by Techwin on 01/07/21.
//

import UIKit

class UserWithProgressTVC: UITableViewCell {

    @IBOutlet weak var progressview: UIProgressView!
    @IBOutlet weak var imageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageview.roundImgCorner(radius: imageview.bounds.height / 2)
        imageview.layer.borderWidth = 1
        imageview.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
