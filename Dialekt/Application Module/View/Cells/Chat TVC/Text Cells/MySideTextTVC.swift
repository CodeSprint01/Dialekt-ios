//
//  MySideTextTVC.swift
//  Dialekt
//
//  Created by Vikas saini on 21/05/21.
//

import UIKit

class MySideTextTVC: UITableViewCell {

    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
