//
//  PublicFunctions.swift
//  DummyProject
//
//  Created by Vikas saini on 16/01/21.
//

import Foundation
import AVFoundation
import UIKit
import NaturalLanguage



func detectedLanguage(for string: String) -> String? {
    let recognizer = NLLanguageRecognizer()
    recognizer.processString(string)
    guard let languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
    let detectedLanguage = Locale.current.localizedString(forIdentifier: languageCode)
    return detectedLanguage
}


//MARK:- PRINT TO CONSOLE

//CONTRIBUTED BY VIKAS SAINI DATED 16 JAN 2021

//FUNCTION USE PRINT STATEMENT TO PRINT ONLY IN DEBUG MODE AND PREVENT TO  PRINT TO CONSOLE IF IS NOT DEBUGGING
//PRINT STATEMENT IN RELEASE MODE CAN SLOW DOWN THE APPLICATION

public func PrintToConsole(_ message: String) {
    #if DEBUG
    print(message)
    #endif
}

//USAGE :  PrintToConsole("SomeMessage")

//MARK:- TEXT TO SPEECH
//CONTRIBUTED BY VIKAS SAINI DATED MARCH 15 2021


var utterance = AVSpeechUtterance()
var synthesizer = AVSpeechSynthesizer()

func SpeakAText(_ text : String){
    utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
    utterance.rate = 0.4
    if !synthesizer.isSpeaking {
    synthesizer.speak(utterance)
    }
}

func SpeakAHindiText(_ text : String){
    utterance = AVSpeechUtterance(string: text)
    utterance.voice = AVSpeechSynthesisVoice(language: "hi-IN")
    utterance.rate = 0.4
    if !synthesizer.isSpeaking {
    synthesizer.speak(utterance)
    }
}

//USAGE : SpeakAText("Welcome Home")

@IBDesignable
class DashedLineView : UIView {
    @IBInspectable var perDashLength: CGFloat = 2.0
    @IBInspectable var spaceBetweenDash: CGFloat = 2.0
    @IBInspectable var dashColor: UIColor = MainColor


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let  path = UIBezierPath()
        if height > width {
            let  p0 = CGPoint(x: self.bounds.midX, y: self.bounds.minY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.midX, y: self.bounds.maxY)
            path.addLine(to: p1)
            path.lineWidth = width

        } else {
            let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
            path.addLine(to: p1)
            path.lineWidth = height
        }

        let  dashes: [ CGFloat ] = [ perDashLength, spaceBetweenDash ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineCapStyle = .butt
        dashColor.set()
        path.stroke()
    }

    private var width : CGFloat {
        return self.bounds.width
    }

    private var height : CGFloat {
        return self.bounds.height
    }
}

extension UIView {
    
    /// Set the view layer as an hexagon
    func setupHexagonView(_ cornerRadius: CGFloat = 4) {
        let lineWidth: CGFloat = 2
        let path = self.roundedPolygonPath(rect: self.bounds, lineWidth: lineWidth, sides: 6, cornerRadius: cornerRadius, rotationOffset: CGFloat(.pi / 2.0))
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.lineWidth = lineWidth
        mask.strokeColor = UIColor.clear.cgColor
        mask.fillColor = UIColor.white.cgColor
        self.layer.mask = mask
        
        let border = CAShapeLayer()
        border.path = path.cgPath
        border.lineWidth = lineWidth
        border.strokeColor = UIColor.white.cgColor
        border.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(border)
    }
    
    
    /// Makes a bezier path which can be used for a rounded polygon
    /// layer
    ///
    /// - Parameters:
    ///   - rect: uiview rect bounds
    ///   - lineWidth: width border line
    ///   - sides: number of polygon's sides
    ///   - cornerRadius: radius for corners
    ///   - rotationOffset: offset of rotation of the view
    /// - Returns: the newly created bezier path for layer mask
    public func roundedPolygonPath(rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat, rotationOffset: CGFloat = 0) -> UIBezierPath {
        let path = UIBezierPath()
        let theta: CGFloat = CGFloat(2.0 * .pi) / CGFloat(sides) // How much to turn at every corner
        let width = min(rect.size.width, rect.size.height)        // Width of the square
        
        let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)
        
        // Radius of the circle that encircles the polygon
        // Notice that the radius is adjusted for the corners, that way the largest outer
        // dimension of the resulting shape is always exactly the width - linewidth
        let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
        
        // Start drawing at a point, which by default is at the right hand edge
        // but can be offset
        var angle = CGFloat(rotationOffset)
        
        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
        path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))
        
        for _ in 0..<sides {
            angle += theta
            
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
            let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
            let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))
            
            path.addLine(to: start)
            path.addQuadCurve(to: end, controlPoint: tip)
        }
        
        path.close()
        
        // Move the path to the correct origins
        let bounds = path.bounds
        let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0, y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
        path.apply(transform)
        
        return path
    }
}



//MARK:- GET WINDOW WHILE USING SCENE DELEGATE
func GetWindow() -> UIWindow? {

// iOS13 or later
if #available(iOS 13.0, *) {
    let sceneDelegate = UIApplication.shared.connectedScenes
        .first?.delegate as? SceneDelegate
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    return sceneDelegate?.window ?? appDelegate?.window
// iOS12 or earlier
} else {
    // UIApplication.shared.keyWindow?.rootViewController
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    return appDelegate?.window
    
}

}


func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
    DispatchQueue.global().async { //1
        let asset = AVAsset(url: url) //2
        let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
        avAssetImageGenerator.appliesPreferredTrackTransform = true //4
        let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
        do {
            let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
            let thumbImage = UIImage(cgImage: cgThumbImage) //7
            DispatchQueue.main.async { //8
                completion(thumbImage) //9
            }
        } catch {
            debugPrint(error.localizedDescription) //10
            DispatchQueue.main.async {
                completion(nil) //11
            }
        }
    }
}
