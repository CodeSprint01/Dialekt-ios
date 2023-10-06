//
//  MySideImageTVC.swift
//  Dialekt
//
//  Created by Macmini2021-vik on 29/09/21.
//

import UIKit

class MySideImageTVC: UITableViewCell {
   
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var ImageViewForThumbnail: UIImageView!
    @IBOutlet weak var PlayImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupTime(_ date : Date){
        if Calendar.current.isDateInToday(date) {
            let df = DateFormatter()
            df.dateFormat = "h:mm a"
            timeLabel.text = df.string(from: date)
        }else {
            let df = DateFormatter()
            df.dateFormat = "MMM d, h:mm a"
            timeLabel.text = df.string(from: date)
        }
        
    }
    
}
