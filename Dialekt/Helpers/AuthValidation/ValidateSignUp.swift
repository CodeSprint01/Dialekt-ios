
//CONTRIBUTED BY: SHIV KUMAR - 15 FEB, 2021

//  ValidateSignUp
import Foundation

struct SignUpData {
    
    var email: String
    var password: String
    var confirmPassword: String

    init(with email: String, password: String, confirmPassword: String) throws {
        
        guard !email.isEmpty else {
            throw ValidationError.empty(UserValidatableAttribute.Email)
        }
        
        guard email.isEmail else {
            throw ValidationError.invalid(UserValidatableAttribute.Email)
        }
        
        guard !password.isEmpty else {
            throw ValidationError.empty(UserValidatableAttribute.Password)
        }
        
        guard password.count >= 8 && password.count <= 24 else {
            throw ValidationError.invalid(UserValidatableAttribute.Password)
        }
        
        guard !confirmPassword.isEmpty else {
            throw ValidationError.empty(UserValidatableAttribute.ConfirmPassword)
        }
        
        guard password == confirmPassword else {
            throw ValidationError.isNotMatch(UserValidatableAttribute.Password, UserValidatableAttribute.ConfirmPassword)
        }
        
        self.email = email
        self.password = password
        self.confirmPassword = confirmPassword
    }
}

/*
//MARK: USAGE

let emailString = emailTF.text?.trimmed() ?? ""
let passwordString = passwordTF.text?.trimmed() ?? ""
let confirmPasswordString = confirm_passwordTF.text?.trimmed() ?? ""
do {
    let signUpData = try SignUpData(with: emailString, password: passwordString, confirmPassword: confirmPasswordString)
    firstSignUp(parameters:["email" :signUpData.email, "password":signUpData.password, "devicetype":"1", "devicetoken":Constant.DeviceTokenId] )
} catch let error as ValidationError {
    UniversalMethod.universalManager.custom_ActionSheet(vc: self, message:error.message)
} catch {
}
*/
