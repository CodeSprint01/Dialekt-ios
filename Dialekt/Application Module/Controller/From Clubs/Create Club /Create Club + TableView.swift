//
//  Create Club + TableView.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import Foundation
import UIKit

extension CreateClubVC : UITableViewDelegate , UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.createClubTVC.identifier, for: indexPath) as?  CreateClubTVC {
            cell.setupCell(allUsers[indexPath.row])
            if selectedIndexes.contains(allUsers[indexPath.row].id ?? 0){
                cell.tickImage.image = R.image.check()
            }else {
                cell.tickImage.image = nil
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexes.contains(allUsers[indexPath.row].id ?? 0) {
            if let index = selectedIndexes.firstIndex(of: allUsers[indexPath.row].id ?? 0) {
                selectedIndexes.remove(at: index)
            }
        }else {
            selectedIndexes.append(allUsers[indexPath.row].id ?? 0)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

}

