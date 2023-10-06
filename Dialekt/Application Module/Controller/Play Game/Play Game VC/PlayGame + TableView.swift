//
//  PlayGame + TableView.swift
//  Dialekt
//
//  Created by Techwin on 01/07/21.
//

import Foundation
import UIKit

extension PlayGameVC : UITableViewDelegate , UITableViewDataSource {
    
    func setupUserTableView(){
        DispatchQueue.main.async {
            self.usersTableView.delegate = self
            self.usersTableView.dataSource = self
            self.usersTableView.separatorStyle = .none
            self.usersTableView.reloadData()
            self.usersTableView.register(UINib(nibName: R.reuseIdentifier.userWithProgressTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.userWithProgressTVC.identifier)
            self.usersTableView.separatorStyle = .none
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        OtherUserPointsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userWithProgressTVC.identifier, for: indexPath) as? UserWithProgressTVC {
            let thisData = OtherUserPointsData[indexPath.row]
            cell.imageview.sd_setImage(with: URL(string: IMAGE_BASE_URL + (thisData.image ?? "")), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
            if let totalQ = thisData.totalQuestion?.toInt() , let CorrectAns = thisData.correctAnswer?.toInt() {
                cell.progressview.progress = Float(CorrectAns)/Float(totalQ)
            }else {
                cell.progressview.progress = 0.0
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 31//UITableView.automaticDimension
    }
    
}
