//
//  QuestionOptionWithoutImageTVC.swift
//  Dialekt
//
//  Created by Techwin on 21/06/21.
//

import UIKit

class QuestionOptionWithoutImageTVC: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.backView.giveShadow()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(_ isSelected : Bool, text : String){
        self.label.text = text
        if isSelected {
            self.backView.backgroundColor = MainColor
            self.label.textColor = .white
        }else {
            self.backView.backgroundColor = .white
            self.label.textColor = .black
        }
    }
    
    func configureCellForChatbot(_ isSelected : Bool){
//        self.label.text = text
        if isSelected {
            self.backView.backgroundColor = GreenColor
            self.label.textColor = .white
        }else {
            self.backView.backgroundColor = GrayColor
            self.label.textColor = .black
        }
    }
}
