//
//  JoinedClubsTVC.swift
//  Dialekt
//
//  Created by Vikas saini on 18/05/21.
//

import UIKit

class JoinedClubsTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var clubImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lastMessagelabel: UILabel!
    @IBOutlet weak var clubNameLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.backView.giveShadow()
            self.clubImage.roundImgCorner(radius: self.clubImage.bounds.height / 2)
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
