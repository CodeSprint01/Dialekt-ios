//
//  SenderTextTVC.swift
//  Dialekt
//
//  Created by Vikas saini on 21/05/21.
//

import UIKit

class SenderTextTVC: UITableViewCell {

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
    
    func setupTime(_ date : Date){
        if Calendar.current.isDateInToday(date) {
            let df = DateFormatter()
            df.dateFormat = "h:mm a"
            timeLabel.text = df.string(from: date)
        }else {
            let df = DateFormatter()
            df.dateFormat = "MMM d,h:mm a"
            timeLabel.text = df.string(from: date)
        }
        
    }

 
}
