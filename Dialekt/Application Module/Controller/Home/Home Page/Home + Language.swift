//
//  Home + Language.swift
//  Dialekt
//
//  Created by Vikas saini on 20/05/21.
//

import Foundation
import UIKit
import SDWebImage

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    func setupCollectionView(){
        self.languageCollectionView.delegate = self
        self.languageCollectionView.dataSource = self
        self.languageCollectionView.register(UINib(nibName: R.reuseIdentifier.languageSelectionCVC.identifier, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.languageSelectionCVC.identifier)
        self.languageCollectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        self.languageCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allLanguagesData.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.languageSelectionCVC.identifier, for: indexPath) as! LanguageSelectionCVC
        cell.backView.roundViewCorner(radius: 10)
        if indexPath.row == 0 {
            cell.backView.layer.borderWidth = 1
            cell.backView.layer.borderColor = UIColor.lightGray.cgColor//MainColor.cgColor
            cell.LanguageImage.image = R.image.plusIcon()
            cell.languageLabel.text = "Add Course"
            cell.languageLabel.textColor = .lightGray
        }else {
            cell.backView.layer.borderWidth = 1
            cell.backView.layer.borderColor = MainColor.cgColor//UIColor.lightGray.cgColor
            cell.LanguageImage.sd_setImage(with: URL(string: IMAGE_BASE_URL + (allLanguagesData[indexPath.row - 1].flag ?? "")), placeholderImage: #imageLiteral(resourceName: "city"), options: [.highPriority], context: nil)
            cell.languageLabel.text = allLanguagesData[indexPath.row - 1].language_type ?? ""
            if allLanguagesData[indexPath.row - 1].language_type != UserDefaults.standard.string(forKey: UD_USERLANGUAGE) {
                cell.languageLabel.textColor = .lightGray
            }else {
                cell.languageLabel.textColor = MainColor
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 120, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let vc = R.storyboard.initialTests.selectDialectViewController(){
                vc.isFromChooseLanguage = true
                self.present(vc, animated: true, completion: nil)
            }
        }else {
            apiCallForChangeUserLanguage(allLanguagesData[indexPath.row - 1].language_type ?? "")
        }
    }
    
    
    
}
