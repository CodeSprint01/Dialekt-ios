//
//  SettingsTVC.swift
//  Dialekt
//
//  Created by Vikas saini on 12/05/21.
//

import UIKit

class SettingsTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.roundViewCorner(radius: 08)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(image: UIImage, text: String , isSelected : Bool){
        
        self.imageview.image = image
        self.label.text = text
        
        if isSelected {
            self.imageview.tintColor = .white
            self.label.textColor = .white
            self.backView.backgroundColor = MainColor
            self.backView.layer.borderWidth = 2
            self.backView.layer.borderColor = MainColor.cgColor
        }else {
            self.imageview.tintColor = .darkGray
            self.label.textColor = .darkGray
            self.backView.backgroundColor = .white
            self.backView.layer.borderWidth = 2
            self.backView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
}
