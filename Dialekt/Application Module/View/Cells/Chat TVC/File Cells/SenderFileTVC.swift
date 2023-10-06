//
//  SenderFileTVC.swift
//  Dialekt
//
//  Created by Macmini2021-vik on 29/09/21.
//

import UIKit

class SenderFileTVC: UITableViewCell {

    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var senderImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.senderImage.roundViewCorner(radius: 20)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
