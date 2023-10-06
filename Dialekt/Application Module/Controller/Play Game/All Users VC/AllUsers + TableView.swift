//
//  AllUsers + TableView.swift
//  Dialekt
//
//  Created by Techwin on 06/07/21.
//

import Foundation
import UIKit

extension AllUsersVC : UITableViewDelegate , UITableViewDataSource {
   
    
    //MARK:- SETUP TABLE VIEW
    func setupTableView(){
        self.tableView.register(UINib(nibName: R.reuseIdentifier.createClubTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.createClubTVC.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.createClubTVC.identifier, for: indexPath) as?  CreateClubTVC {
            cell.setupCell(allUsers[indexPath.row])
            if selectedIndexes.contains(allUsers[indexPath.row].userID ?? 0){
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
        if selectedIndexes.contains(allUsers[indexPath.row].userID ?? 0) {
            if let index = selectedIndexes.firstIndex(of: allUsers[indexPath.row].userID ?? 0) {
                selectedIndexes.remove(at: index)
            }
        }else {
            selectedIndexes.append(allUsers[indexPath.row].userID ?? 0)
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    
    
}

//
//extension AllUsersVC {
//
//    //MARK:- SCROLL VIEW DID END DECELERATING
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//          guard scrollView == tableView else {return}
//          print("scrollViewDidEndDecelerating")
//          guard total_pages != 1 else {return}
//          let remainingPagesCount = total_pages - current_page
//          print("remainingPagesCount", remainingPagesCount)
//          _ = scrollView.contentOffset.y
//          let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//          if scrollView == tableView{
//              if (scrollView.contentOffset.y == /*0*/ maximumOffset ) {
//                  if remainingPagesCount < 1{}else{
//                    let pageNo = current_page + 1
//                    apiCallForUserList(search: tfSearch.text?.trimmed() ?? "", Page: pageNo)
//                  }
//              }
//          }
//      }
//}
