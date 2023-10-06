//
//  ChatViewController.swift
//  Dialekt
//
//  Created by iApp on 13/09/22.
//

import UIKit
import Speech
import AVKit
import AVFoundation
import IQKeyboardManagerSwift


class ChatViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var topView: UIView!
    @IBOutlet var topViewHeight: NSLayoutConstraint!
    @IBOutlet var vWCorrectTtile: UIView!
    @IBOutlet var vWCorrectWord: UIView!
    
    
    @IBOutlet var btnSoundCorrectWord: UIButton!
    @IBOutlet var lblCorrectWord: UILabel!
    
    
    @IBOutlet var stackViewHeight: NSLayoutConstraint!
    @IBOutlet var vWActualWord: UIView!
    @IBOutlet var vWUserSaidWord: UIView!
    @IBOutlet var lblActualWord: UILabel!
    @IBOutlet var btnSoundActualWord: UIButton!
    
    
    @IBOutlet var vWTextView: UIView!
    @IBOutlet var viewMicrophone: UIView!
    @IBOutlet var textFld: UITextField!
    
    
    
     // MARK: - Variables
     //------------------------------------------------------------------------------

     let speechRecognizer        = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))

     var recognitionRequest      : SFSpeechAudioBufferRecognitionRequest?
     var recognitionTask         : SFSpeechRecognitionTask?
     let audioEngine             = AVAudioEngine()
     var isPlaySound = true

    @IBOutlet var btnStartSpeech: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizedUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        //updateContaintsHeight.changeMultiplier(stackViewHeight, multiplier: 0.45)
        self.view.layoutIfNeeded()
    }
    
    
    // MARK:-
    // MARK:- Custom Methods
    //------------------------------------------------------------------------------
    
    func  customizedUI() {
        vWCorrectWord.giveShadowAndRoundCorners(shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 5, opacity: 0.5, shadowColor: .lightGray, cornerRadius:15)
        vWActualWord.giveShadowAndRoundCorners(shadowOffset: CGSize(width: 0, height: 0), shadowRadius: 5, opacity: 0.5, shadowColor: .lightGray, cornerRadius:15)
        vWCorrectTtile.cornerRadius = 15
        vWUserSaidWord.cornerRadius = 15
        vWTextView.cornerRadius = 18
        textFld.cornerRadius = 19
        viewMicrophone.cornerRadius = viewMicrophone.frame.height/2
        textFld.attributedPlaceholder = NSAttributedString(
            string: "Type Your Word…",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        textFld.delegate = self
        btnStartSpeech.cornerRadius = btnStartSpeech.frame.height/2
        stackViewHeight = stackViewHeight.constraintWithMultiplier(0.3)
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.setupSpeech()
     }
    
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupSpeech() {
        
        self.btnStartSpeech.isEnabled = false
        self.btnStartSpeech.alpha = 0.5
        self.speechRecognizer?.delegate = self

        SFSpeechRecognizer.requestAuthorization { (authStatus) in

            var isButtonEnabled = false

            switch authStatus {
            case .authorized:
                isButtonEnabled = true

            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")

            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")

            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
                
            @unknown default:
                print("fetal error ")
            }

            OperationQueue.main.addOperation() {
                self.btnStartSpeech.isEnabled = isButtonEnabled
                if isButtonEnabled {
                    self.btnStartSpeech.alpha = 1.0
                } else {
                    self.btnStartSpeech.alpha = 0.5
                }
            }
        }
    }
    
    
    //------------------------------------------------------------------------------

        func startRecording() {

            // Clear all previous session data and cancel task
            if recognitionTask != nil {
                recognitionTask?.cancel()
                recognitionTask = nil
            }

            // Create instance of audio session to record voice
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.measurement, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                print("audioSession properties weren't set because of an error.")
            }

            self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

            let inputNode = audioEngine.inputNode

            guard let recognitionRequest = recognitionRequest else {
                fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
            }

            recognitionRequest.shouldReportPartialResults = true

            self.recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in

                var isFinal = false

                if result != nil {

                    self.lblActualWord.text = result?.bestTranscription.formattedString
                    self.textFld.text = result?.bestTranscription.formattedString
                    isFinal = (result?.isFinal)!
                }

                if error != nil || isFinal {

                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)

                    self.recognitionRequest = nil
                    self.recognitionTask = nil

                    self.btnStartSpeech.isEnabled = true
                    self.btnStartSpeech.alpha = 1
                }
            })

            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
                self.recognitionRequest?.append(buffer)
            }

            self.audioEngine.prepare()

            do {
                try self.audioEngine.start()
            } catch {
                print("audioEngine couldn't start because of an error.")
            }

            self.textFld.text = "Type your Word..."
    }

    
    
    @IBAction func btnMicrophoneTapped(_ sender: UIButton) {
       // if isPlaySound {
       //   isPlaySound = false
         
       // }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.audioEngine.isRunning {
                self.audioEngine.stop()
                self.recognitionRequest?.endAudio()
                self.btnStartSpeech.isEnabled = false
                self.btnStartSpeech.alpha = 1.0
                 print("stop recording")
                self.textFld.text = ""
                self.textFld.placeholder = "Type Your Word…"

             } else {
                self.startRecording()
                 self.btnStartSpeech.alpha = 0.5
//                 self.playSound()
                 print("start recording")
               // self.btnStartSpeech.setTitle("Stop Recording", for: .normal)
            }
        }
    }
    
    
    @IBAction func btnSoundActualWordTapped(_ sender: UIButton) {
         let string = lblActualWord.text ?? ""
         let utterance = AVSpeechUtterance(string: string)
         utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

         let synthesizer = AVSpeechSynthesizer()
         synthesizer.speak(utterance)
    }
    
    
    @IBAction func btnSoundCorrectWordTapped(_ sender: UIButton) {
        let string = lblCorrectWord.text ?? ""
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        lblActualWord.text = textFld.text
        lblCorrectWord.text =  textFld.text
        textFld.text = ""
        return true
    }
    
    private func playSound() {
        
      var audioPlayer: AVAudioPlayer?
      guard let url = Bundle.main.url(forResource: "heart", withExtension: "caf") else { return }
      
      do {
        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
        audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
        
        guard let player = audioPlayer else { return }
        
        player.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
          player.pause()
          audioPlayer = nil
        }
          
      } catch let error {
        print(error.localizedDescription)
      }
    }
 }

//------------------------------------------------------------------------------
// MARK:-
// MARK:- SFSpeechRecognizerDelegate Methods
//------------------------------------------------------------------------------

extension ChatViewController: SFSpeechRecognizerDelegate {

    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.btnStartSpeech.isEnabled = true
            self.btnStartSpeech.alpha = 1.0
        } else {
            self.btnStartSpeech.isEnabled = false
            self.btnStartSpeech.alpha = 0.5
        }
    }
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}


extension ChatViewController {
    
    struct updateContaintsHeight {
      static func changeMultiplier(_ constraint: NSLayoutConstraint, multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
          item: constraint.firstItem,
          attribute: constraint.firstAttribute,
          relatedBy: constraint.relation,
          toItem: constraint.secondItem,
          attribute: constraint.secondAttribute,
          multiplier: multiplier,
          constant: constraint.constant)

         newConstraint.priority = constraint.priority

        NSLayoutConstraint.deactivate([constraint])
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
      }
    }
}
