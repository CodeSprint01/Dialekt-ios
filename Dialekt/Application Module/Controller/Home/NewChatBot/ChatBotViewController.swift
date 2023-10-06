//
//  ChatBotViewController.swift
//  Dialekt
//
//  Created by iApp-iOS-10 on 26/10/22.
//

import UIKit

class ChatBotViewController: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var soundIconButton: UIButton!
    @IBOutlet weak var soungBgView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var labelanswerStatus: UILabel!
    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var answerStatusBgView: UIView!
    @IBOutlet weak var textToTranslatelabel: UILabel!
    @IBOutlet weak var pulseView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    //MARK: - Variables Declared
    var selectedIndex = 123456
    var isSelected: Bool = false
    var thisData : QuestionlistingModelDataClass?
    var pulseArray = [CAShapeLayer]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        soungBgView.isHidden = true
        answerStatusBgView.isHidden = true
        setupCollection()
    }
    
    //MARK: - VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        self.view.layoutIfNeeded()
    }
    
    func setupCollection() {
        self.tblView.register(UINib(nibName: R.reuseIdentifier.questionOptionWithoutImageTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.questionOptionWithoutImageTVC.identifier)
        self.tblView.delegate = self
        self.tblView.dataSource = self
        self.tblView.separatorStyle = .none
        self.tblView.reloadData()
    }
   
    func createPulse(_ View: UIView) {
        for _ in 0...2 {
            let circularPath = UIBezierPath(arcCenter: .zero, radius: ((View.superview?.frame.size.width )! )/2, startAngle: 0, endAngle: 2 * .pi , clockwise: true)
            let pulsatingLayer = CAShapeLayer()
            pulsatingLayer.path = circularPath.cgPath
            pulsatingLayer.lineWidth = 2.5
            pulsatingLayer.fillColor = MainColor.withAlphaComponent(0.4).cgColor
            pulsatingLayer.lineCap = CAShapeLayerLineCap.round
            pulsatingLayer.position = CGPoint(x: View.frame.size.width / 2.0, y: View.frame.size.width / 2.0)
            View.layer.addSublayer(pulsatingLayer)
            pulseArray.append(pulsatingLayer)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.animatePulsatingLayerAt(index: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                self.animatePulsatingLayerAt(index: 1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.animatePulsatingLayerAt(index: 2)
                    //For Removing , otherwise it will get dark and dark everytime
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.pulseArray.removeAll()
                    }
                })
            })
        })
    }
    
    func animatePulsatingLayerAt(index:Int) {
        
        //Giving color to the layer
        guard index < pulseArray.count else {return}
        pulseArray[index].strokeColor = UIColor.clear.cgColor
        //Creating scale animation for the layer, from and to value should be in range of 0.0 to 1.0
        //0.0 = minimum
        //1.0 = maximum
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.0
        scaleAnimation.toValue = 0.4
        
        //Creating opacity animation for the layer, from and to value should be in range of 0.0 to 1.0
        //0.0 = minimum
        //1.0 = maximum
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.fromValue = 0.4
        opacityAnimation.toValue = 0.0
        
        // Grouping both animations and giving animation duration, animation repat count
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [scaleAnimation, opacityAnimation]
        groupAnimation.duration = 2.3
        groupAnimation.repeatCount = .greatestFiniteMagnitude
        groupAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        //adding groupanimation to the layer
        pulseArray[index].add(groupAnimation, forKey: "groupanimation")
        
        //for Stoping after 2
        if index == 2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                for layer in self.pulseView.layer.sublayers ?? [] {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
    
    //MARK: - Back Button Action
    @IBAction func btbBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - Tableview delegate and datasource
extension ChatBotViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4// thisData?.option?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionOptionWithoutImageTVC.identifier, for: indexPath) as? QuestionOptionWithoutImageTVC {
            cell.selectionStyle = .none
            cell.configureCellForChatbot(selectedIndex == indexPath.row)
            cell.label.text = "Hey Siri"
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionOptionWithoutImageTVC.identifier, for: indexPath) as? QuestionOptionWithoutImageTVC {
            selectedIndex = indexPath.row
            //        createPulse(self.pulseView)
            cell.label.text = "Hey Siri"
            SpeakAText(cell.label.text ?? "")
            textToTranslatelabel.text =  cell.label.text
            if cell.label.text == "Hey Siri" {
                self.labelanswerStatus.text = "Correct"
            } else {
                self.labelanswerStatus.text = "InCorrect"
            }
            soungBgView.isHidden = false
            answerStatusBgView.isHidden = false
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
}
