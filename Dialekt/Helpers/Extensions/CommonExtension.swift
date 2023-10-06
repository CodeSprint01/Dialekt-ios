
//  Created by RajputShiv on 27/03/21.

import Foundation
import UIKit

//MARK:- For giving multipal Color to single label value

//CONTRIBUTED BY SHIV SINGH THAKUR DATED MARCH 27 2021

extension NSMutableAttributedString {
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}

/*
//USAGE :
let completeString = "Total followers this Year is 12k"
attributedString = NSMutableAttributedString(string: completeString ?? "")
attributedString?.setColorForText(textForAttribute: "Year", withColor: UIColor(named: "#8FB61C") ?? UIColor.green)
attributedString?.setColorForText(textForAttribute: "12k", withColor: UIColor(named: "#8FB61C") ?? UIColor.green)
currentYearTotalFollowers.font = UIFont(name: "Quicksand-Bold", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0)
currentYearTotalFollowers.attributedText = attributedString
*/



//MARK:- IMAGE EXTENSION


extension UIImage {
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}
