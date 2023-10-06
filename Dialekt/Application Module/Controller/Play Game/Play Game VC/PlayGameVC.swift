//
//  PlayGameVC.swift
//  Dialekt
//
//  Created by Techwin on 30/06/21.
//

import UIKit

class PlayGameVC: UIViewController {

    
    //MARK:- OUTLETS
    
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var QuestionNumberStackView: UIStackView!
    @IBOutlet weak var Q1Label: UILabel!
    @IBOutlet weak var Q2Label: UILabel!
    @IBOutlet weak var Q3Label: UILabel!
    @IBOutlet weak var Q4Label: UILabel!
    @IBOutlet weak var Q5Label: UILabel!
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var BottomViewForQuestions: UIView!
    @IBOutlet weak var myProgressView: UIProgressView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var NextButton: UIButton!
    
    //MARK:- CONSTANT AND VARIABLES
    var gameID = ""
    var groupID = ""
    var OtherUserPointsData = [OtherUserGamePointsModelDataClass]()
    var allQuestionsData = [QuestionlistingModelDataClass]()
    var whichContainer = 1 // can be 1, 2, 3 or 4 , 5 , By Default 1
    var populated = 0
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- SETUP UI
    func setupUI(){
        DispatchQueue.main.async {
            for aView in self.QuestionNumberStackView.arrangedSubviews {
            aView.roundViewCorner(radius: aView.bounds.height / 2)
                aView.layer.borderWidth = 1
                aView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
             }
            self.myImageView.roundImgCorner(radius: self.myImageView.bounds.height / 2)
            self.myImageView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
            self.myImageView.layer.borderWidth = 1
            self.BottomViewForQuestions.roundViewCorner(radius: 25)
            self.BottomViewForQuestions.backgroundColor = MainColor.withAlphaComponent(0.4)
            self.setupLevel()
            self.myImageView.sd_setImage(with: URL(string: IMAGE_BASE_URL + (UserDefaults.standard.string(forKey: UD_USERIMAGE) ?? "")), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
            self.myProgressView.progress = 0.0
            self.apiCallForMyPoints()
            self.apiCallForOtherUsersPoints()
            self.apiCallForGetQuestionList()
            self.topLabel.text = "Play Game"
            NotificationCenter.default.addObserver(self, selector: #selector(self.PlayAgainFunctionality), name: NSNotification.Name.init("PlayAgain"), object: nil)
        }

    }
    
    //MARK:- PLAY AGAIN FUNCTIONALITY
    @objc func PlayAgainFunctionality(){
        self.setupAfterGettingData()
        self.populated = 0
        self.setupLevel()
    }
    
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        //  PrintToConsole("top safe \(self.view.safeAreaInsets.top)")
        DispatchQueue.main.async {
            self.topView.addBottomRoundedEdge(desiredCurve: 1.5)
        }
    }
    
    //MARK:- GO BACK
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func setupLevel(){
        
        for i in 0...QuestionNumberStackView.arrangedSubviews.count-1 {
             let aLabel = QuestionNumberStackView.arrangedSubviews[i] as! UILabel
            if i <= populated-1 {
                aLabel.backgroundColor = MainColor
                aLabel.textColor = .white
            }else {
                aLabel.backgroundColor = .white
                aLabel.textColor = MainColor
            }
        }

    }
    
    //MARK:- NEXT QUESTION BUTTON
    @IBAction func NextQuestionButtonTapped(_ sender: Any) {
        NextButton.isUserInteractionEnabled = false
        var selectedIndex = 0
        if let vc = self.children.first as? TestProgressContainer1VC {
            PrintToConsole("here 1 \(vc.textToTranslate) \(vc.finalText)")
            if vc.textToTranslate.trimmed().components(separatedBy: .whitespaces).count == 1 {
//                if vc.finalText.replacingOccurrences(of: " ", with: "").trimmed() == vc.textToTranslate.trimmed() {
//                    Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
//                }else {
//                    Toast.show(message: "Wrong Answer\nCorrect Answer is '\(vc.textToTranslate)'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
//                }
            HitAnswerApi(QuestionID: String(vc.thisData?.id ?? 0), Answer: vc.finalText.replacingOccurrences(of: " ", with: "").trimmed())
            }else {
//            if vc.finalText.trimmed() == vc.textToTranslate.trimmed() {
//                Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
//            }else {
//                Toast.show(message: "Wrong Answer\nCorrect Answer is '\(vc.textToTranslate)'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
//            }
                HitAnswerApi(QuestionID: String(vc.thisData?.id ?? 0), Answer: vc.finalText.trimmed())
            }
        }
        else if let vc = self.children.first as? TestProgressContainer5 {
//            if vc.finalText.trimmed() == vc.thisData?.answer?.trimmed() {
//                Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
//            }else {
//                Toast.show(message: "Wrong Answer\nCorrect Answer is '\(vc.thisData?.answer ?? "")'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
//            }
            HitAnswerApi(QuestionID: String(vc.thisData?.id ?? 0), Answer: vc.finalText.trimmed())
        }
        else
        if let vc = self.children.first as? TestProgressContainer2VC {
            selectedIndex = vc.selectedIndex
            ShowAnswer(vc.selectedIndex)
        }else
        if let vc = self.children.first as? TestProgressContainer3VC {
            selectedIndex = vc.selectedIndex
           ShowAnswer(vc.selectedIndex)
        }else
        if let vc = self.children.first as? TestProgressContainer4VC {
            selectedIndex = vc.selectedIndex
           ShowAnswer(vc.selectedIndex)
        }else{}
        
        guard selectedIndex != 123456 else {
            self.NextButton.isUserInteractionEnabled = true
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            guard self.populated < self.allQuestionsData.count else {
//                Toast.show(message: "Game is complete", controller: self)
//                if self.isFromGameLevel {
//                    if let vc  = R.storyboard.playGame.levelResultVC(){
//                        vc.GameID = self.gameId
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                }else {
//                if let vc = R.storyboard.auth.signViewController() {
//                    vc.selectedCity = self.selectedCity
//                    vc.selectedLanguage = self.selectedLanguage
//                    vc.selectedLevel = self.selectedLevel
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//                }
                self.NextButton.isUserInteractionEnabled = true
                return
            }
            if let firstType = self.allQuestionsData[self.populated].type {
                if let firstTypeInt = firstType.toInt() {
                    DispatchQueue.main.async {
                        self.setContainer(firstTypeInt)
                    }
                }
            }
            self.NextButton.isUserInteractionEnabled = true
        }
        
    }
    
    
    func setupAfterGettingData() {
        if let firstType = self.allQuestionsData.first?.type {
            if let firstTypeInt = firstType.toInt() {
                DispatchQueue.main.async {
                    self.setContainer(firstTypeInt)
                }
            }
        }
    }
    
    func HitAnswerApi(QuestionID : String , Answer : String){
        apiCallForSubmittingAnswer(QuestionID, answer: Answer, isLastQuestion: QuestionID == allQuestionsData.last?.id?.toString)
    }
    
    
    func ShowAnswer(_ number : Int) {
        if number == 123456 {Toast.show(message: "Choose an option", controller: self)}else {
            if let selectedAnswer = self.allQuestionsData[populated - 1].option?[number].option , let _ = self.allQuestionsData[populated - 1].answer{
//                if selectedAnswer == answer {
//                    Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
//                }else {
//                    Toast.show(message: "Wrong Answer\nCorrect Answer is '\(answer)'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
//                }
                HitAnswerApi(QuestionID: String(self.allQuestionsData[populated - 1].id ?? 0), Answer: selectedAnswer)
            }
        }
    }
    
    
    
    func setContainer(_ number : Int){
        switch number {
        case 1 :
            if let vc = R.storyboard.initialTests.testProgressContainer3VC(){
                vc.thisData = allQuestionsData[populated]
                removeChild()
                vc.view.backgroundColor = .clear
                self.addChildView(viewControllerToAdd: vc, in: ContainerView)
            }
        case 2 :
            if let vc = R.storyboard.initialTests.testProgressContainer2VC(){
                removeChild()
                vc.thisData = allQuestionsData[populated]
                vc.view.backgroundColor = .clear
                self.addChildView(viewControllerToAdd: vc, in: ContainerView)
            }
        case 3 :
            if let vc = R.storyboard.initialTests.testProgressContainer1VC(){
                removeChild()
                vc.thisData = allQuestionsData[populated]
                vc.view.backgroundColor = .clear
                self.addChildView(viewControllerToAdd: vc, in: ContainerView)
            }
        case 4 :
            if let vc = R.storyboard.initialTests.testProgressContainer4VC(){
                removeChild()
                vc.thisData = allQuestionsData[populated]
                vc.view.backgroundColor = .clear
                self.addChildView(viewControllerToAdd: vc, in: ContainerView)
            }
        case 5 :
            if let vc = R.storyboard.initialTests.testProgressContainer1VC(){
                removeChild()
                vc.thisData = allQuestionsData[populated]
                vc.view.backgroundColor = .clear
                self.addChildView(viewControllerToAdd: vc, in: ContainerView)
            }
        case 6:
            if let vc = R.storyboard.initialTests.testProgressContainer5(){
                removeChild()
                vc.thisData = allQuestionsData[populated]
                vc.view.backgroundColor = .clear
                self.addChildView(viewControllerToAdd: vc, in: ContainerView)
            }
        default:
            break
        }
        populated = populated + 1
        setupLevel()
    }
    
}
