//
//  QuizType4VC.swift
//  Dialekt
//
//  Created by Vikas Saini on 16/11/21.
//

import UIKit

class QuizType4VC: UIViewController {
    
    @IBOutlet weak var TopLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var tfBlank: UITextField!
    
    var thisData : QuestionlistingModelDataClass?
    var finalText = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = thisData?.question {
        let dataArray = data.components(separatedBy: "_")
            TopLabel.text = dataArray.first?.replacingOccurrences(of: "_", with: "").trimmed() ?? ""
            bottomLabel.text = dataArray.last?.replacingOccurrences(of: "_", with: "").trimmed() ?? ""
        }
        tfBlank.addTarget(self, action: #selector(TextIsChanging(_:)), for: .editingChanged)
    }
    
    @objc func TextIsChanging(_ tf: UITextField) {
        finalText = tf.text?.trimmed() ?? ""
    }
}
