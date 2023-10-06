//
//  TestProgressContainer5.swift
//  Dialekt
//
//  Created by Techwin on 02/08/21.
//

import UIKit
import Speech

class TestProgressContainer5: UIViewController , SFSpeechRecognizerDelegate{
    
    @IBOutlet weak var soundViewBottom: NSLayoutConstraint!
    @IBOutlet weak var soundViewTop: NSLayoutConstraint!
    @IBOutlet weak var micView: UIView!
    @IBOutlet weak var PulseView: UIView!
    @IBOutlet weak var crossView: UIView!
    @IBOutlet weak var tfText: UITextField!
    @IBOutlet weak var labelForText: UILabel!
    @IBOutlet weak var viewForText: UIView!
    @IBOutlet weak var soundView: UIView!
    @IBOutlet weak var microphoneButton: UIButton!
    
    
    //MARK:- VARIABLES
    var pulseArray = [CAShapeLayer]()
    var textToTranslate = "Dummy text here for now"
    var finalText = ""
    var thisData : QuestionlistingModelDataClass?
    let speechRecognizer = SFSpeechRecognizer()
    var isMicViewHidden = false//if true , it means it is coming from quiz
    var isType6 = false //Quiz type 6
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        micView.isHidden = isMicViewHidden
        textToTranslate = thisData?.question ?? ""
        if isMicViewHidden {
            //this will be from quiz
            textToTranslate = thisData?.answer ?? ""
        }
        self.viewForText.roundViewCorner(radius: 8)
        self.viewForText.layer.borderWidth = 1
        self.viewForText.layer.borderColor = UIColor.lightGray.cgColor
        DispatchQueue.main.async {
            self.soundView.roundViewCorner(radius: self.soundView.bounds.height / 2)
            self.PulseView.roundViewCorner(radius: self.PulseView.bounds.height / 2)
            self.micView.roundViewCorner(radius: self.micView.bounds.height / 2)
        }
        if isMicViewHidden || isType6 {
            self.labelForText.text = thisData?.question ?? ""
        }else {
            self.labelForText.text = textToTranslate
        }
        setupSpeech()
        self.tfText.addTarget(self, action: #selector(TextIsChanging), for: .editingChanged)
    }
    
    
    //MARK:- TEXT IS CHANGEING
    @objc func TextIsChanging(_ tf : UITextField){
        self.finalText = tf.text?.trimmed() ?? ""
    }
    
    func setupSpeech() {
        
        microphoneButton.isEnabled = false  //2
        
        speechRecognizer?.delegate = self  //3
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in  //4
            var isButtonEnabled = false
            switch authStatus {  //5
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
                break
            }
            
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
        }
    }
    
    @IBAction func SoundButtonClicked(_ sender: Any) {
        
        defer {
            disableAVSession()
        }
        // Quieten (but don't stop) any other audio
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        }
        catch let error as NSError {
            print("Error: Could not set audio category: \(error), \(error.userInfo)")
        }
        
        createPulse(self.PulseView)
        
        if detectedLanguage(for: self.labelForText.text ?? "") == "Hindi" {
            SpeakAHindiText(self.labelForText.text ?? "")
        }else {
            if isMicViewHidden {
                SpeakAText(textToTranslate)
            }else {
                SpeakAText(self.labelForText.text ?? "")
            }
        }
    }
    
    private func disableAVSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't disable.")
        }
    }
    
    @IBAction func MicClicked(_ sender: Any) {
        //        let audioSession = AVAudioSession.sharedInstance()
        //        do {
        //          try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
        //          try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        //        }
        //         catch let error as NSError {
        //          print("ERROR:", error)
        //        }
        disableAVSession()
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
            // microphoneButton.setTitle("Start Recording", for: .normal)
        } else {
            createPulse(self.micView)
            startRecording()
            // microphoneButton.setTitle("Stop Recording", for: .normal)
        }
    }
    
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                self.tfText.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                self.microphoneButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        PrintToConsole("Say something, I'm listening!")
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }
    
    //MARK: - PULSE CREATION METHODS
    
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
