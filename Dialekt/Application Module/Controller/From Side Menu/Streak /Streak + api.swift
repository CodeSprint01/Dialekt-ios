//
//  Streak + api.swift
//  Dialekt
//
//  Created by Techwin on 30/07/21.
//

import Foundation

extension StreakVC {
    
    
    //MARK:- API CALL FOR GETTING DAILY STREAK
    
    func apiCallForGettingStreak(){
        DispatchQueue.main.async {
        startAnimating(self.view)
        }
        let params = [String: Any]()
        ApiManager.shared.Request(type: DailyStreakModel.self, methodType: .Get, url: BASE_URL + GET_DAILY_STREAK_API , parameter: params) { (error, response, message, statusCode) in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                stopAnimating()
            }
            if statusCode == 200 {
                if let data = response?.data {
                 PrintToConsole("response of Streak api \(String(describing: response))")
                 let dataIs = data.sorted(by: { $0.id! > $1.id! })
                
                  DispatchQueue.main.async {
                    for d in dataIs {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let date = dateFormatter.date(from: d.date ?? "1970-01-01") ?? Date()
                        self.allDates.append(date)
                    }
                    self.getStreakNumber(dataIs )
                    self.CalendarView.delegate = self
                    self.CalendarView.dataSource = self
                    self.CalendarView.reloadData()
                }
                }else {
                    Toast.show(message: DATA_NOT_FOUND, controller: self)
                }
              
            } else {

                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
    
     
    func getStreakNumber(_ array : [DailyStreakModelDataClass]  ) {
        
        var streak = 0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let firstdate = dateFormatter.date(from: array.first?.date ?? "1970-01-01") {
                var result = [[String]]()
                var tempArr = [String]()
                for (index, date) in allDates.enumerated() {
                    tempArr.append(dateFormatter.string(from: date))
                    if index+1 < allDates.count {
                    if let days = Calendar.current.dateComponents([.day], from: date, to: allDates[index+1]).day, days > 1 {
                        result.append(tempArr)
                        tempArr = []
                        }
                    } else {
                        result.append(tempArr)
                    }
                }
            PrintToConsole("result \(result)")
            streak = result.first?.count ?? 0
            
            if !Calendar.current.isDateInToday(firstdate) || !Calendar.current.isDateInYesterday(firstdate) {
                streak = 0
            }
            
            self.labelINMiddel.text = "\(streak)"
            
        }
        
        PrintToConsole("streak count \(streak)")
  
    }

}
