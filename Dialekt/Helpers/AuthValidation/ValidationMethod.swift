
//CONTRIBUTED BY: SHIV KUMAR - 15 FEB, 2021

//  ValidationMethod
import Foundation

enum ValidationError: Error {
    
    case empty(_: ValidatableAttribute)
    case invalid(_: ValidatableAttribute)
    case invalidWithReason(_: ValidatableAttribute, reason: String)
    case isMatch(_: ValidatableAttribute, ValidatableAttribute)
    case isNotMatch(_: ValidatableAttribute, ValidatableAttribute)
    case Mandtory(_: ValidatableAttribute)
    var message: String {
        
        switch self {
        case .empty(let attribute):
            return "Empty \(attribute.name)"
        case .invalid(let attribute):
            return "Invalid \(attribute.name) or Format is not correct"
        case .invalidWithReason(let attribute, let reason):
            return "Invalid \(attribute.name). \(reason)"
        case .isMatch(let firstAttribute, let secondAttribute):
            return "\(firstAttribute.name), \(secondAttribute.name)"
        case .isNotMatch( _,  _):
            return ("Password Mismatch")//"\(firstAttribute.name) and \(secondAttribute.name) is not matched"
        case .Mandtory(let attribute):
            return "Mandatory field didn't fill - \(attribute.name)"
        }
    }
}

protocol ValidatableAttribute {
    var name: String { get }
}

enum UserValidatableAttribute: String, ValidatableAttribute {
    case FirstName
    case LastName
    case Email
    case confirmEmail
    case Password
    case ConfirmPassword
    case specialisations
    case Location
    case Options
    var name: String {
        return self.rawValue
    }
}
