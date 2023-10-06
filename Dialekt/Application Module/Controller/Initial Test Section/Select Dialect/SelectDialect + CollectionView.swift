//
//  Select City + Collection View.swift
//  Dialekt
//
//  Created by Vikas saini on 09/05/21.
//

import Foundation
import UIKit


extension SelectDialectViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
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
            cell.label.text = allCitiesData[indexPath.row].languageType ?? "--"
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
                self.apiCallForUpdateCityAndDailekt(self.SelectedCity , dailekt :self.allCitiesData[indexPath.row].languageType ?? "--" , userid: String(self.socailLoggedInUserDetail?.id ?? 0))
            }
            else if self.isFromSignUp {
                NotificationCenter.default.post(name: NSNotification.Name.init("updateLanguage"), object: nil, userInfo: ["language" : self.allCitiesData[indexPath.row].languageType ?? "--"])
                self.navigationController?.popViewController(animated: true)
            }else if self.isFromChooseLanguage {
                NotificationCenter.default.post(name: NSNotification.Name.init("LanguageSelected"), object: nil, userInfo: ["language" : self.allCitiesData[indexPath.row].languageType ?? "--"])
                self.dismiss(animated: true, completion: nil)
            }else {
                if let vc = R.storyboard.initialTests.quizVC() { // R.storyboard.initialTests.selectDialectLevelViewController() {
                vc.selectedCity = self.SelectedCity
                
//                vc.selectedDailekt = self.allCitiesData[indexPath.row].languageType ?? "--"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            }
        }
    }
}
