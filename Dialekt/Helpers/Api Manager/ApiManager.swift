//
//  ApiManager.swift
//  DummyProject
//
//  Created by Vikas saini on 23/01/21.
//


import Foundation
import UIKit


//Mark:- API MANAGER , MAKE USE OF URL SESSIONS FOR MAKING REQUESTS TO REMOTE SERVER
//CONTRIBUTED BY VIKAS SAINI (DATED 23 JAN 2020)

//CONTAIN PUT , PATCH, POST , GET , DELETE AND MULTIPART(POST) REQUEST
//READ CAREFULLY & THOROUGHLY BEFORE MAKING USE
//COMMENTS WERE ADDED WHEREEVER REQUIRED
//FEEL FREE TO CONTACT VIKAS SAINI IN CASE OF QUERRIES OR IMPROVEMENTS

class ApiManager  {
    
    public static let shared = ApiManager()
    private init(){}
    
    //IF YOUR BACKEND IS USING BASIC AUTHENTICATION , PLEASE ADD YOUR USERNAME AND PASSWORD THERE, IT WILL BE USED INSIDE THE METHOD
    //IN CASE OF NO USERNAME AND PASSWORD , LEAVE THEM AS IT IS
    
    let USERNAME = ""
    let PASSWORD = ""
    
    //MARK:- ALERT METHOD FOR SHOWING INTERNET CONNECTION ERROR
    //TO BE USED IN THE MEHODS
    func callInternetAlert(){
        let alertController = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    //MARK:- REQUEST METHOD
    func Request<T:Decodable>(type: T.Type ,methodType: MethodType,url:String ,parameter: [String:Any],completion:@escaping (_ error: Error?, _ myObject: T? , _ msgString : String? , _ statusCode : Int?) -> ()){
        
        //CHECKING INTERNET CONNECTIVTY
        guard Connectivity.isConnectedToInternet else {
            //IF NOT CONNECTED TO INTERNET , GO OUT OF METHOD ,SHOW ALERT AND STOP INDICATOR
            stopAnimating()
            callInternetAlert()
            return
        }
        
        //CHECKING URL VALIDATION
        guard let url = URL(string: url) else {
            //IF NOT A VALID URL , SHOW ALERT , STOP INDICATOR AND RETURN
            stopAnimating()
            Toast.show(message: "Invalid Url !", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: UIColor.red)
            return
        }
        
        //CREATING A NEW URL SO THAT WE CAN APPEND IN CASE OF GET OR DELETE REQUEST
        var finalUrl = url
        
        if methodType == .Get || methodType == .Delete {
            //MOSTLY , GET AND DELETE REQUESTS DO NOT HAVE A BODY AND QUERY PARAMS ARE APPENDED TO URL, WE WILL USE THE PARAMETER TO GENERATE A [String: String] DICTIONARY AND THEN APPEND TO URL
            
            let stringDictionary = CovertToStringDict(parameter)
           
            //CHECKING IF WE CAN APPEND PARAMETERS TO STRING URL
            guard let newURl = url.append(queryParameters: stringDictionary) else {
                stopAnimating()
                Toast.show(message: "Unable to Generate appended Url for \(methodType.rawValue) request !", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: UIColor.red)
                return
            }
            //GENERATE NEW URL
            finalUrl = newURl
            PrintToConsole("GENERATED URL FOR \(methodType.rawValue) request : \(finalUrl)")
        }else {
            //PRINTING PARAMETERS TO CONSOLE
            PrintToConsole("Parameters for \(finalUrl) : \(parameter)")
        }
        
        //CREATING REQUEST FROM URL
        var request = URLRequest(url: finalUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        //DEFINING REQUEST TYPE
        request.httpMethod = methodType.rawValue
        
        //SETTING UP BASIC AUTH IF USERNAME AND PASSWORD IS ADDED
        if USERNAME != "" {
            let loginString = "\(USERNAME):\(PASSWORD)"
            guard let loginData = loginString.data(using: String.Encoding.utf8) else {
                return
            }
            let base64LoginString = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        }
     
        
        //SETTING SESSION KEY TO HEADER
        //CHECK FOR THIS STEP YOURSELF, SOME BACKEND DEVELOPER SET THERE OWN KEY (say "sessionkey" or "sessionKey" or something else) IN PLACE OF "Authorization" ,  ALSO SOMETIMES SESSIONKEY IS PASSED LIKE "Bearer \(sessionKey)" , THIS DEPEND ON BACKEDN , YOU NEED TO CHECK THAT FOR ONE TIME ONLY
        if UserDefaults.standard.string(forKey: UD_TOKEN) != nil {
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: UD_TOKEN)!)", forHTTPHeaderField: "Authorization")
        }
        
        //Below line was an experiment
//        if url.absoluteString == BASE_URL + GAME_LISTING_API {
//        request.addValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiY2JkMDk0MDQ1YmNlYzlhMGRkMjFjZTgwMjJmYzEwZDUxOWM3NmM5OWUwNDAzNWVhMzJkODVkYTNlMDNhYzIwYzdhYjgxZDkxZWMxYzVjYjkiLCJpYXQiOjE2MjQ4NjYxNDEuMzEzMjM1OTk4MTUzNjg2NTIzNDM3NSwibmJmIjoxNjI0ODY2MTQxLjMxMzI0MTAwNDk0Mzg0NzY1NjI1LCJleHAiOjE2NTY0MDIxNDEuMjgzMTA2MDg4NjM4MzA1NjY0MDYyNSwic3ViIjoiMTgiLCJzY29wZXMiOltdfQ.ZIuOUXpKQboCGa6ZahSbSC00hZeYIbtESotXdyr80PA9vTyG7kLfTIcTIUzqaA8t5oiKHvBhUi8wlhTexXycoZppNzrJmceVWecKFUtQyfsxEPxFZ07rmOHQqIcTPRhGt-Auk6GRWBqp6BAa1Tzisyx7HHH9iAMv69wHqzXb2kkfQ2t03Iyp0cwY2wO9YqCzNpbteTYRYCCtyKQ4vgyoXIUiUzFJjckAOq0IlLI1y8hYfI2bIk9NsScGirAufbqpCjcbYiBV1w2aVQYL8r6yOg5Oxw7XWdbL4ufU5fGy8hrlEd_oS50CFima58UDLVzfGqYd9SdLZ268lDc7KAAP6dKxJettaApyTnSR9xJrT3yIRL5wMrMqJRZatX-IfeJWPQ9oJMgddljgIK2YOCyLIDi3WL-b9oK0swncdQoMw3jSiKOXwWez3O1LB4bUb88tqc_armul9UydI-tyak0ULEk0I_VhqvwY6bmDmmHeuUFICE2gYJXhYILq0s4tLhoEJixMymGhRQCYd2pn3R7Xbseofk5eBDH3aTW1NXMwloAdZEfd5h25OHkKila1FUQNaEbSIPSMTaUlASRQ8NJBgV6XSNoUXl9Ul-S2nwFs7a5mW8qocOCtMeih3TtCwmF6HSWIS_vGiAD-4rqjY-1lTozFwx-HIVp2yaj3EfbAEmQ", forHTTPHeaderField: "Authorization")
//        }
        
        //YOU CAN PASS OTHER HEADERS ACCORDING TO YOUR REQUIREMENT
        //USING request.setValue("VALUE_HERE", forHTTPHeaderField: "HEADER_HERE")
        //SETTING UP BODY
        if methodType == .Post {
            //below line if it going in form data
            //request.httpBody = parameter.percentEncoded()
            //below line if it is going in raw data
            let postData = try! JSONSerialization.data(withJSONObject: parameter, options: [.fragmentsAllowed])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            request.httpBody = postData

        }else {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if methodType == .Get || methodType == .Delete {
             //GET METHOD MUST NOT HAVE A BODY , SAME GOES FOR DELETE , I GUESS
            }else if methodType == .Patch || methodType == .Put{
                let postData = try? JSONSerialization.data(withJSONObject: parameter, options: [])
                request.httpBody = postData
            }
        }
        
        
        //SENDING REQUEST
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
       
            //STOP LOADER AS SOON AS THE RESULT ARRIVE
            stopAnimating()
            
            //CHECKING FOR ERROR
            guard error == nil else {
                DispatchQueue.main.async {
                Toast.show(message: "Error : \(error!.localizedDescription)", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: .red)
                }
                return
            }
            
            //CHECKING FOR RIGHT OUTPUT
            guard let httpResponse = response as? HTTPURLResponse else {
                //THIS HAPPENDS MOSTLY IN CASE OF SERVER ERROR
                DispatchQueue.main.async {
                Toast.show(message: "Something Went Wrong !", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: .red)
                }
                return
            }
            
            
            PrintToConsole("STATUS CODE FOR \(finalUrl) : \(httpResponse.statusCode)")
            
            if httpResponse.statusCode == 200 || httpResponse.statusCode == 202 {
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data!)
                    completion(nil,decoded , nil ,httpResponse.statusCode)
                } catch let errorr   {
                    //IF YOU ARE GETTING ERROR IN MODEL DECODING , FORCE URWRAP try (put ! after try)  , APPLICATION WILL CRASH AND THE INFORMATION ABOUT THE KEY THAT IS CAUSING TROUBLE, WILL GET PRINTED TO CONSOLE
                    completion(errorr,nil , nil ,httpResponse.statusCode)
                }
            }else{
                stopAnimating()
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: [JSONSerialization.ReadingOptions() , .allowFragments]) as! [String:Any]
                    PrintToConsole("JSON OF FAILED REQUEST \(jsonResponse)")
                    //CHECK FOR MESSAGE KEY IN THE ABOVE RESPONSE AND ENTER BELOW IN PLACE OF "message"
                    completion(error, nil , jsonResponse["message"] as? String ?? "Something Went Wrong" , httpResponse.statusCode)
                }catch let errr {
                    completion(errr,nil , nil , httpResponse.statusCode)
                    
                }
            }
        }).resume()
    }
    
    //Usage:
    
    //IMPORTANT NOTE:-
    //YOU DON'T HAVE TO APPEND QUERRY PARAMS TO URL FOR USING GET AND DELETE REQUEST , JUST PASS THE PARAMETERS IN parameters AND METHOD WILL AUTOMATICALLY APPEND IT TO URL STRING IN CASE OF GET AND DELETE REQUEST
    
    /*
     WITH SESSION KEY :
     
     ApiManager.shared.Request(type: SomeModel.self, methodType: MethodType.Post, url: "your url string here", parameter: [String:Any]()) { (error, response, stringMessage, statusCode) in
     //Get your response here
     }
     
     WITHOUT SESSION KEY:
     
     ApiManager.shared.Request(type: SomeModel.self, methodType: MethodType.Get, url: "your url string here", sessionKey: "your session key here(Pass Nil if not required)", parameter: [String:Any]()) { (error, response, stringMessage, statusCode) in
         //Get your response here
     }
     
     */
   
    
    //MARK:- MULTIPART FORM DATA REQUEST
    public func requestWithImage<T:Decodable>(type: T.Type,url:String, parameter:[String:Any]?,fileType : FileType? = FileType.Image ,imageNames: [String], images:[Data], completion: @escaping(_ error:Error?, _ myObject: T?,_ messageStr:String?,_ statusCode :Int?)->Void) {
        
        
        //CHECKING INTERNET CONNECTIVTY
        guard Connectivity.isConnectedToInternet else {
            //IF NOT CONNECTED TO INTERNET , GO OUT OF METHOD ,SHOW ALERT AND STOP INDICATOR
            stopAnimating()
            callInternetAlert()
            return
        }
        
        //CHECKING URL VALIDATION
        guard let url = URL(string: url) else {
            //IF NOT A VALID URL , SHOW ALERT , STOP INDICATOR AND RETURN
            stopAnimating()
            Toast.show(message: "Invalid Url !", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: UIColor.red)
            return
        }
        
        
            // generate boundary string using a unique per-app string
            let boundary = UUID().uuidString
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            
          
        request.httpMethod = MethodType.Post.rawValue
        //SETTING UP BASIC AUTH IF USERNAME AND PASSWORD IS ADDED
        if USERNAME != "" {
            let loginString = "\(USERNAME):\(PASSWORD)"
            guard let loginData = loginString.data(using: String.Encoding.utf8) else {
                return
            }
            let base64LoginString = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        }
        
        if UserDefaults.standard.string(forKey: UD_TOKEN) != nil {
            request.setValue("Bearer \(UserDefaults.standard.string(forKey: UD_TOKEN)!)", forHTTPHeaderField: "Authorization")
        }

            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            var data = Data()
            if parameter != nil{
                for(key, value) in parameter!{
                    // Add the reqtype field and its value to the raw http request data
                    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                    data.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                    data.append("\(value)".data(using: .utf8)!)
                }
            }
        
        if fileType == .Video {
            for (index,imageData) in images.enumerated() {
                // Add the image data to the raw http request data
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(imageNames[index])\"; filename=\"\(imageNames[index]).mp4\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: video/mp4\r\n\r\n".data(using: .utf8)!)
                data.append(imageData)
            }
        }else if fileType == .Pdf {
            for (index,imageData) in images.enumerated() {
                // Add the image data to the raw http request data
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(imageNames[index])\"; filename=\"\(imageNames[index]).pdf\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: application/pdf\r\n\r\n".data(using: .utf8)!)
                data.append(imageData)
            }
        }else {
            //image
            for (index,imageData) in images.enumerated() {
                // Add the image data to the raw http request data
                data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
                data.append("Content-Disposition: form-data; name=\"\(imageNames[index])\"; filename=\"\(imageNames[index]).png\"\r\n".data(using: .utf8)!)
                data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
                data.append(imageData)
            }
        }
            
            // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
            
            // Send a POST request to the URL, with the data we created earlier
            
            session.uploadTask(with: request, from: data , completionHandler: { (data, response, error) in
                //STOP LOADER AS SOON AS THE RESULT ARRIVE
                stopAnimating()
                
                //CHECKING FOR ERROR
                guard error == nil else {
                    DispatchQueue.main.async {
                    Toast.show(message: "Error : \(error!.localizedDescription)", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: .red)
                    }
                    return
                }
                
                //CHECKING FOR RIGHT OUTPUT
                guard let httpResponse = response as? HTTPURLResponse else {
                    //THIS HAPPENDS MOSTLY IN CASE OF SERVER ERROR
                    DispatchQueue.main.async {
                    Toast.show(message: "Something Went Wrong !", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: .red)
                    }
                    return
                }
                
                    if httpResponse.statusCode == 200{
                        guard let data = data else {
                            completion(error, nil,nil,httpResponse.statusCode)
                            return
                        }
                        PrintToConsole(String(data: data, encoding: .utf8)!)
                        guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
                            DispatchQueue.main.async {
                            Toast.show(message: "Unable to decode Model!", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: .red)
                        }
                            return
                        }
                        completion(nil,decodeData,nil,httpResponse.statusCode)
                        
                    }else{
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: [.mutableContainers,.allowFragments]) as! [String: Any]
                            completion(nil, nil,(json["message"] as? String),httpResponse.statusCode)
                            PrintToConsole("Json of Failed mutlipart request \(json)")
                        } catch let myJSONError {
                            completion(myJSONError,nil,nil,httpResponse.statusCode)
                        }
                        
                    
                    }
            }).resume()
        }
    
    
    //USAGE :- SAME AS ABOVE METHOD

    }
    




extension Dictionary {
  public  func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}



// MARK:- APPENING QUERRY PARAMS TO URL FOR GET AND DELETE REQUEST
extension URL {
  func append(queryParameters: [String: String]) -> URL? {
      guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
        Toast.show(message: "Unable to Bind Url !", controller: (UIApplication.shared.keyWindow?.rootViewController)!, color: .red)
          return nil
      }

      let urlQueryItems = queryParameters.map {
          return URLQueryItem(name: $0, value: $1)
      }
      urlComponents.queryItems = urlQueryItems
      return urlComponents.url
  }
}

//MARK:- CONVERT [STRING : ANY]() TO [STRING: STRING]()
func CovertToStringDict(_ dict : [String:Any]) -> [String:String] {
    var newDict = [String:String]()
    for (key, value) in dict {
        newDict[key] = "\(value)"
    }
    return newDict
}



