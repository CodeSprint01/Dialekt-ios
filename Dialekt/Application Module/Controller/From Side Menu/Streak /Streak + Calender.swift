//
//  Streak + Calender.swift
//  Dialekt
//
//  Created by Techwin on 30/07/21.
//

import Foundation
import FSCalendar

extension StreakVC : FSCalendarDelegate , FSCalendarDataSource , FSCalendarDelegateAppearance{

    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        if allDates.contains(date){
            return [MainColor]
        }
        else {
            return [.clear]
        }
    }
    
    
}
