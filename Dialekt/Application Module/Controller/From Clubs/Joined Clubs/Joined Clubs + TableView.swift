//
//  Joined Clubs + TableView.swift
//  Dialekt
//
//  Created by Vikas saini on 18/05/21.
//

import Foundation
import UIKit

extension JoinedClubsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myAllClubsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.joinedClubsTVC.identifier, for: indexPath) as? JoinedClubsTVC{
            let thisClub = myAllClubsArray[indexPath.row]
            if let imageUrl = thisClub.image {
            cell.clubImage.sd_setImage(with: URL(string: IMAGE_BASE_URL + imageUrl), placeholderImage: #imageLiteral(resourceName: "city"), options: [.highPriority], context: nil)
            }else{
                cell.clubImage.image = #imageLiteral(resourceName: "city")
            }
            cell.clubNameLabel.text = thisClub.clubName ?? ""
            if let dateOfMessage = (thisClub.createdAt ?? "").toDate() {
                cell.timeLabel.text = dateOfMessage.timeAgoSinceDate()
            }else {
                cell.timeLabel.text = "- - -"
            }
            let lastMessageUserName = thisClub.user?.name ?? "Unknown User"
            let lastMessage = thisClub.message ?? "--"
            if thisClub.file == nil {
            cell.lastMessagelabel.text = lastMessageUserName+" : "+lastMessage
            }else{
            cell.lastMessagelabel.text = "\(lastMessageUserName) : FILE"
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = R.storyboard.fromClubs.chatVC() {
            vc.ClubID = (myAllClubsArray[indexPath.row].clubID ?? "0").toInt() ?? 0
            vc.clubName = myAllClubsArray[indexPath.row].clubName ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}




