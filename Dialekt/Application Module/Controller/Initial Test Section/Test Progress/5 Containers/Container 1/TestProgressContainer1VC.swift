//
//  TestProgressContainer1VC.swift
//  Dialekt
//
//  Created by Vikas saini on 24/05/21.
//

import UIKit

class TestProgressContainer1VC: UIViewController {
    
    
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var PulseView: UIView!
    @IBOutlet weak var crossView: UIView!
    @IBOutlet weak var tfText: UITextField!
    @IBOutlet weak var labelForText: UILabel!
    @IBOutlet weak var viewForText: UIView!
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    //MARK:- VARIABLES
    var pulseArray = [CAShapeLayer]()
    var textToTranslate = "Dummy text here for now"
    var textArray = [String]()
    var finalText = ""
    var thisData : QuestionlistingModelDataClass?
    var isFromQuiz = false
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        textToTranslate = thisData?.answer ?? ""
        self.viewForText.roundViewCorner(radius: 8)
        self.viewForText.layer.borderWidth = 1
        self.viewForText.layer.borderColor = UIColor.lightGray.cgColor
        DispatchQueue.main.async {
        self.soundView.roundViewCorner(radius: self.soundView.bounds.height / 2)
        self.PulseView.roundViewCorner(radius: self.PulseView.bounds.height / 2)
        self.crossView.roundViewCorner(radius: self.crossView.bounds.height / 2)
        }
        if isFromQuiz {
            self.labelForText.text = thisData?.question ?? ""
        }else {
        self.labelForText.text = textToTranslate
        }
        if textToTranslate.trimmed().components(separatedBy: .whitespaces).count == 1 {
            self.textArray = textToTranslate.map { String($0) }.shuffled()
        }else {
        self.textArray = textToTranslate.components(separatedBy: .whitespaces).shuffled()
        }
//        PrintToConsole("text Array \(textArray)")
//        PrintToConsole("count is there \(textToTranslate.trimmed().components(separatedBy: .whitespaces).count) ")
        self.setupCollectionView()
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = 140 //collectionView.contentSize.height
    }
    
    //MARK:- BUTTON ACTIONS
    @IBAction func crossButtonClicked(_ sender: Any) {
        crossView.isHidden = true
        finalText = ""
        tfText.text = finalText
        if textToTranslate.trimmed().components(separatedBy: .whitespaces).count == 1 {
            self.textArray = textToTranslate.map { String($0) }.shuffled()
        }else {
        self.textArray = textToTranslate.components(separatedBy: .whitespaces)
        }
//        PrintToConsole("count is there \(textToTranslate.trimmed().components(separatedBy: .whitespaces).count) ")
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.viewDidLayoutSubviews()
        }
    }
    
    @IBAction func soundButtonClicked(_ sender: Any) {
        createPulse(self.PulseView)
        SpeakAText(self.labelForText.text ?? "")
    }
    
    
    //MARK:- PULSE CREATION METHODS
    
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
        scaleAnimation.toValue = 0.9
        
        //Creating opacity animation for the layer, from and to value should be in range of 0.0 to 1.0
        //0.0 = minimum
        //1.0 = maximum
        let opacityAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        opacityAnimation.fromValue = 0.9
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
            for layer in self.PulseView.layer.sublayers ?? [] {
                layer.removeFromSuperlayer()
            }
        }
    }
}
    
    
}
