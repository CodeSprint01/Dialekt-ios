//
//  Daily Goal + tableView.swift
//  Dialekt
//
//  Created by Vikas saini on 17/05/21.
//

import Foundation
import UIKit

extension DailyGoalParameterVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dailyGoalsTVC.identifier, for: indexPath) as? DailyGoalsTVC {
            cell.label1.text = FirstArray[indexPath.row]
            cell.label2.text = SecondArray[indexPath.row] + " min per day"
            cell.backView.layer.borderWidth = 1
            cell.backView.roundViewCorner(radius: 8)
            if indexPath.row == selectedIndex {
                cell.label2.textColor = .white
                cell.label1.textColor = .white
                cell.backView.backgroundColor = MainColor
                cell.backView.layer.borderColor = MainColor.cgColor
            }else {
                cell.label2.textColor = .lightGray
                cell.label1.textColor = .lightGray
                cell.backView.backgroundColor = UIColor.white
                cell.backView.layer.borderColor = UIColor.lightGray.cgColor
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        DispatchQueue.main.async {
            self.apiCallForUpdatingDailyGoal(String(self.selectedIndex+1))
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    
}
