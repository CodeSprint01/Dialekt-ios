//
//  TestPerformanceVC.swift
//  Dialekt
//
//  Created by Macmini2021-vik on 14/10/21.
//

import UIKit

class TestPerformanceVC: UIViewController {
    
    var totalQuestions = 0
    var totalAnswers = 0

    @IBOutlet weak var labellevel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var PerformanceLabel: UILabel!
    @IBOutlet weak var WhiteView: UIView!
    @IBOutlet weak var startOverButton: UIButton!
    @IBOutlet weak var JoinBUtton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupText()
        JoinBUtton.roundViewCorner(radius: 08)
        startOverButton.roundViewCorner(radius: 08)
    }
    
    func SetupText() {
        let ratio: Float = Float(totalAnswers) / Float(totalQuestions)
        scoreLabel.text = "Your score is \(totalAnswers) out of \(totalQuestions)"
        if ratio <= 0.4 {
            WeakPerformance()
        } else if ratio > 0.4 && ratio <= 0.6 {
            NotBadPerformance()
        } else {
            GoodPerformance()
        }
    }
    
    func WeakPerformance() {
        labellevel.text = Constant.beginnerText
        PerformanceLabel.text = Constant.OopsText
        DescriptionLabel.text = Constant.beginnerDescription
    }
    
    func NotBadPerformance() {
        labellevel.text = Constant.intermediateText
        PerformanceLabel.text = Constant.notBadtext
        DescriptionLabel.text = Constant.intermediateDescription
    }
    
    func GoodPerformance() {
        labellevel.text = Constant.expertText
        PerformanceLabel.text = Constant.superbText
        DescriptionLabel.text = Constant.expertDescription
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.WhiteView.clipsToBounds = true
            self.WhiteView.roundCorners(corners: [.topLeft , .topRight], radius: 25)
        }
    }
    
    @IBAction func startOverButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            if let vc = GetWindow()?.topViewController() {
                vc.navigationController?.popToRootViewController(animated: false)
            }
        }
    }
    
    @IBAction func JoinUsButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
            //MARK:- OBSERVER POST TO GO TO SIGNUP SCREEN AND IT ADDED IN TestProgressVC
            NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "GoForSignUP"), object: nil, userInfo: nil)
        }
    }
}
