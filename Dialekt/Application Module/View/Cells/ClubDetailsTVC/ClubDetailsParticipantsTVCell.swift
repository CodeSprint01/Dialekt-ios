//
//  ClubDetailsParticipantsTVCell.swift
//  Dialekt
//
//  Created by iApp on 24/08/22.
//

import UIKit

class ClubDetailsParticipantsTVCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(_ data: ClubMember) {
        nameLbl.text = data.memberName
        profileImageView.sd_setImage(with: URL(string: data.memberImage), placeholderImage: UIImage(named: "person"), options: [.highPriority], context: nil)
    }
    
    @IBAction func removeBtnAction(_ sender: Any) {
        
    }
    
    
    
}
