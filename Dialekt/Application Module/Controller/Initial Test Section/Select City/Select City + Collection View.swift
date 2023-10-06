//
//  Select City + Collection View.swift
//  Dialekt
//
//  Created by Vikas saini on 09/05/21.
//

import Foundation
import UIKit

import SDWebImage

extension SelectCityViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCitiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.selectCityCVC.identifier, for: indexPath) as? SelectCityCVC {
            cell.backView.layer.borderColor = MainColor.cgColor
            cell.label.text = allCitiesData[indexPath.row].city ?? "--"
            cell.imageview.sd_setImage(with: URL(string: IMAGE_BASE_URL + (allCitiesData[indexPath.row].flag ?? "")), placeholderImage: #imageLiteral(resourceName: "city"), options: [.highPriority], context: nil)
            if indexPath.item == selectedIndex {
                cell.backView.layer.borderWidth = 1
            }else {
                cell.backView.layer.borderWidth = 0
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        DispatchQueue.main.async {
            self.CollectionView.reloadData()
            if self.isFromSocialLogin {
                // send to select Dailekt
                if let vc = R.storyboard.initialTests.selectDialectViewController(){
                    vc.isFromSocialLogin = self.isFromSocialLogin
                    vc.socailLoggedInUserDetail = self.socailLoggedInUserDetail
                    vc.SelectedCity = self.allCitiesData[indexPath.row].city ?? "--"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }else if self.isFromSignUp {
                NotificationCenter.default.post(name: NSNotification.Name.init("updateCity"), object: nil, userInfo: ["city" : self.allCitiesData[indexPath.row].city ?? "--"])
                self.navigationController?.popViewController(animated: true)
            }else {
                if let vc = R.storyboard.initialTests.selectDialectViewController(){
                    vc.SelectedCity = self.allCitiesData[indexPath.row].city ?? "--"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
    
}
