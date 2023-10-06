//
//  Find Club + Collection view.swift
//  Dialekt
//
//  Created by Vikas saini on 18/05/21.
//

import Foundation
import UIKit


extension FindAClubVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearched ? searchedClubs.count : allClubs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 16)  / 2, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.findClubCVC.identifier, for: indexPath) as? FindClubCVC {
            if isSearched {
            cell.setupCell(searchedClubs[indexPath.row])
            }else {
            cell.setupCell(allClubs[indexPath.row])
            }
            cell.joinButton.tag = indexPath.row
            cell.joinButton.addTarget(self, action: #selector(JoinThisClubClicked), for: UIControl.Event.touchUpInside)
            return cell
        }
        return UICollectionViewCell()
    }
    
    //MARK:- JOIN THIS CLUB
    @objc func JoinThisClubClicked(_ sender : UIButton) {
        let index = sender.tag
        let thisclub = isSearched ? searchedClubs[index] : allClubs[index]
        apiCallForJoinClub(thisclub.clubCode ?? "")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = VC<ClubDetailsVC>.fromClubs.instantiateVC()
        if isSearched {
            vc.clubModel = searchedClubs[indexPath.row]
        }else {
            vc.clubModel = allClubs[indexPath.row]
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
