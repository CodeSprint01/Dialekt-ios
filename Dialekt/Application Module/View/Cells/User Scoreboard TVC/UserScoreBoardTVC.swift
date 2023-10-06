//
//  UserScoreBoardTVC.swift
//  Dialekt
//
//  Created by Techwin on 02/07/21.
//

import UIKit

class UserScoreBoardTVC: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        pointsLabel.roundViewCorner(radius: 04)
        backView.roundViewCorner(radius: 08)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
   
        // Configure the view for the selected state
    }
    
}
