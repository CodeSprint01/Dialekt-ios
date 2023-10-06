//
//  QuizVC.swift
//  Dialekt
//
//  Created by Vikas Saini on 16/11/21.
//

import UIKit

class QuizVC: UIViewController {

    
    //MARK: - OUTLETS
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var containerView: UIView!
    
    
    //MARK:- CONSTANTS
    var whichContainer = 1 // can be 1, 2, 3 or 4 , 5 , By Default 1
    var selectedLanguage = ""
    var selectedCity = ""
    var populated = 0
    var selectedLevel = "1" // 1, 2, 3 in increasing order
    var allQuestionsData = [QuestionlistingModelDataClass]()
    var CorrectAnswerCount = 0
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NextButton.giveShadow()
        apiCallForQuestionList()
        NotificationCenter.default.addObserver(self, selector: #selector(GoNextPage), name: NSNotification.Name.init(rawValue: "GoForSignUP"), object: nil)
        
    }
    
    @objc func GoNextPage() {
                        if let vc = R.storyboard.auth.signViewController() {
                            vc.selectedCity = self.selectedCity
                            vc.selectedLanguage = self.selectedLanguage
                            vc.selectedLevel = self.selectedLevel
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.progressView.roundViewCorner(radius: 5)
        self.NextButton.giveShadow()
        topViewHeight.constant = self.view.safeAreaInsets.top + 45
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    func setContainer(_ number : Int){
        switch number {
            
        case 1 :
            if let vc = R.storyboard.initialTests.testProgressContainer4VC(){
                removeChild()
                vc.topLabelText = "Fill in the blanks"
                vc.thisData = allQuestionsData[populated]
                self.addChildView(viewControllerToAdd: vc, in: containerView)
            }
        case 2 :
            if let vc = R.storyboard.initialTests.testProgressContainer5(){
                removeChild()
                vc.isMicViewHidden = true
                vc.thisData = allQuestionsData[populated]
                self.addChildView(viewControllerToAdd: vc, in: containerView)
             }
        case 3 :
            if let vc = R.storyboard.initialTests.testProgressContainer2VC(){
                removeChild()
                vc.thisData = allQuestionsData[populated]
                self.addChildView(viewControllerToAdd: vc, in: containerView)
            }
        case 4 :
            if let vc = R.storyboard.initialTests.quizType4VC(){
                removeChild()
                vc.thisData = allQuestionsData[populated]
                self.addChildView(viewControllerToAdd: vc, in: containerView)
            }
        case 5 :
            if let vc = R.storyboard.initialTests.testProgressContainer1VC(){
                removeChild()
                vc.isFromQuiz = true
                vc.thisData = allQuestionsData[populated]
                self.addChildView(viewControllerToAdd: vc, in: containerView)
            }
        case 6 :
            if let vc = R.storyboard.initialTests.testProgressContainer5(){
                removeChild()
                vc.thisData = allQuestionsData[populated]
                vc.isType6 = true
                self.addChildView(viewControllerToAdd: vc, in: containerView)
             }
//        case 1 :
//            if let vc = R.storyboard.initialTests.testProgressContainer3VC(){
//                vc.thisData = allQuestionsData[populated]
//                removeChild()
//                self.addChildView(viewControllerToAdd: vc, in: containerView)
//            }
//        case 2 :
//            if let vc = R.storyboard.initialTests.testProgressContainer2VC(){
//                removeChild()
//                vc.thisData = allQuestionsData[populated]
//                self.addChildView(viewControllerToAdd: vc, in: containerView)
//            }
//        case 3 :
//            if let vc = R.storyboard.initialTests.testProgressContainer1VC(){
//                removeChild()
//                vc.thisData = allQuestionsData[populated]
//                self.addChildView(viewControllerToAdd: vc, in: containerView)
//            }
//        case 4 :
//            if let vc = R.storyboard.initialTests.testProgressContainer4VC(){
//                removeChild()
//                vc.thisData = allQuestionsData[populated]
//                self.addChildView(viewControllerToAdd: vc, in: containerView)
//            }
//        case 5 :
//            if let vc = R.storyboard.initialTests.testProgressContainer1VC(){
//                removeChild()
//                vc.thisData = allQuestionsData[populated]
//                self.addChildView(viewControllerToAdd: vc, in: containerView)
//            }
//        case 6:
//            if let vc = R.storyboard.initialTests.testProgressContainer5(){
//                removeChild()
//                vc.thisData = allQuestionsData[populated]
//                self.addChildView(viewControllerToAdd: vc, in: containerView)
//            }
        default:
            break
        }
        populated = populated + 1
        let perc:Double = 1.0/Double(self.allQuestionsData.count)
        self.progressView.progress = Float(perc*Double(populated))
    }
    
    //MARK:- BUTTON ACTION
    @IBAction func nextButtonAction(_ sender: Any) {
        NextButton.isUserInteractionEnabled = false
        var selectedIndex = 0
        if let vc = self.children.first as? TestProgressContainer1VC {
            PrintToConsole("here 1 \(vc.textToTranslate) \(vc.finalText)")
            if vc.textToTranslate.trimmed().components(separatedBy: .whitespaces).count == 1 {
                if vc.finalText.replacingOccurrences(of: " ", with: "").trimmed() == vc.textToTranslate.trimmed() {
                    CorrectAnswerCount += 1
                    Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
                }else {
                    Toast.show(message: "Wrong Answer\nCorrect Answer is '\(vc.textToTranslate)'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
                }
//                HitAnswerApi(QuestionID: String(vc.thisData?.id ?? 0), Answer: vc.finalText.replacingOccurrences(of: " ", with: "").trimmed())
            }else {
            if vc.finalText.trimmed() == vc.textToTranslate.trimmed() {
                CorrectAnswerCount += 1
                Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
            }else {
                Toast.show(message: "Wrong Answer\nCorrect Answer is '\(vc.textToTranslate)'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
            }
//                HitAnswerApi(QuestionID: String(vc.thisData?.id ?? 0), Answer: vc.finalText.trimmed())
            }
        }
        else if let vc = self.children.first as? TestProgressContainer5 {
            if vc.finalText.trimmed() == vc.thisData?.answer?.trimmed() {
                CorrectAnswerCount += 1
                Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
            }else {
                Toast.show(message: "Wrong Answer\nCorrect Answer is '\(vc.thisData?.answer ?? "")'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
            }
//            HitAnswerApi(QuestionID: String(vc.thisData?.id ?? 0), Answer: vc.finalText.trimmed())
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
        }else
            if let vc = self.children.first as? QuizType4VC {
            if vc.thisData?.answer?.trimmed() == vc.finalText {
                CorrectAnswerCount += 1
                Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
            }else {
                Toast.show(message: "Wrong Answer\nCorrect Answer is '\(vc.thisData?.answer ?? "")'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
            }
            }
        else{}
        
        guard selectedIndex != 123456 else {
            self.NextButton.isUserInteractionEnabled = true
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            guard self.populated < self.allQuestionsData.count else {
            PrintToConsole("test here \(self.CorrectAnswerCount)")
            if let vc = R.storyboard.initialTests.testPerformanceVC() {
                    vc.totalQuestions = self.allQuestionsData.count
                    vc.totalAnswers = self.CorrectAnswerCount
                    vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
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
    
//    func HitAnswerApi(QuestionID : String , Answer : String){
//        if isFromGameLevel {
//            apiCallForSubmittingAnswer(QuestionID, answer: Answer)
//        }
//    }
    
    
    func ShowAnswer(_ number : Int) {
        if number == 123456 {Toast.show(message: "Choose an option", controller: self)}else {
            if let selectedAnswer = self.allQuestionsData[populated - 1].option?[number].option , let answer = self.allQuestionsData[populated - 1].answer{
                if selectedAnswer == answer {
                    Toast.show(message: "correct Answer", controller: self , color: UIColor.green.withAlphaComponent(0.7))
                    CorrectAnswerCount += 1
                }else {
                    Toast.show(message: "Wrong Answer\nCorrect Answer is '\(answer)'", controller: self , color: UIColor.red.withAlphaComponent(0.7))
                }
//                HitAnswerApi(QuestionID: String(self.allQuestionsData[populated - 1].id ?? 0), Answer: selectedAnswer)
            }
        }
    }
    
    
}
