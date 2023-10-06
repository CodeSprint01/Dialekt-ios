//
//  ClubDetailsVC + TableView.swift
//  Dialekt
//
//  Created by iApp on 24/08/22.
//

import Foundation
import UIKit


extension ClubDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubDetails?.clubMembers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ClubDetailsParticipantsTVCell", for: indexPath) as? ClubDetailsParticipantsTVCell {
            if let model = clubDetails?.clubMembers[indexPath.row] {
                cell.setupCell(model)
            }
            cell.removeBtn.tag = indexPath.row
            cell.removeBtn.isHidden = clubDetails!.isCreater  ? false : true
            cell.removeBtn.addTarget(self, action: #selector(removeMember(_:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    @objc func removeMember(_ sender: UIButton) {
        guard let clubID = clubModel?.clubID else {return}
        guard let memberUserID = clubDetails?.clubMembers[sender.tag].userID else {return}
        self.apiRemoveMemberFromClub(clubID: clubID, memberUserID: memberUserID) { [weak self] in
            self?.apiGetClubDetails()
        }
    }
}
