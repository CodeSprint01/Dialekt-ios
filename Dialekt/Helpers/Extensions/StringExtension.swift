//
//  StringExtension.swift
//  BaseProject
//
//  Created by Techwin on 21/12/20.
//

import Foundation
import UIKit





extension String {
        
    //MARK:- VARIOUS METHODS FOR STRING
    //CONTRIBUTED BY INDERJEET SINGH
    
    
    /// EZSE: Converts String to Int
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Double
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
        }
    }
    
    /// EZSE: Converts String to Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }
    
    
    func toDate() -> Date? {
        // Create String
        let string = self.UTCToLocal()
        // Create Date Formatter
        let dateFormatter = DateFormatter()
        // Set Date Format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // Convert String to Date
        return dateFormatter.date(from: string)
    }
    
    func UTCToLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Input Format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let UTCDate = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Output Format
        dateFormatter.timeZone = TimeZone.current
        if let date1 = UTCDate {
        let UTCToCurrentFormat = dateFormatter.string(from: date1)
        return UTCToCurrentFormat
        }else {
        return ""
        }
    }
}


//CONTRIBUTED BY: SHIV KUMAR - 15 FEB, 2021
extension String {
    
    func trimmed() -> String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var isEmail: Bool {
        return checkRegEx(for: self, regEx: "^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,})$")
    }
    
    // MARK: - Private Methods
    private func checkRegEx(for string: String, regEx: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regEx)
        return test.evaluate(with: string)
    }
    
    //CONTRIBUTED BY: SHIV KUMAR - 03 MAR, 2021
    func grouping(every groupSize: String.IndexDistance, with separator: Character) -> String {
       let cleanedUpCopy = replacingOccurrences(of: String(separator), with: "")
       return String(cleanedUpCopy.enumerated().map() {
            $0.offset % groupSize == 0 ? [separator, $0.element] : [$0.element]
       }.joined().dropFirst())
    }
    
    /* USAGE ABOVE METHOD
     extension AddPaymentCard: UITextFieldDelegate{
         func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
             guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
             if textField == holderCardNumber {
                 if currentText.count >= 20 {
                     return false
                 }
                 textField.text = currentText.grouping(every: 4, with: " ")
                 return false
             }else {
                 return false
             }
         }
     }
     */
    
    
}
