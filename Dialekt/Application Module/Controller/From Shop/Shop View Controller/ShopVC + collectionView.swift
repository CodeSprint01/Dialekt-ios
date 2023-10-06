//
//  ShopVC + collectionView.swift
//  Dialekt
//
//  Created by Vikas saini on 19/05/21.
//

import Foundation
import UIKit

extension ShopVC : UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shopItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.shopCVC.identifier, for: indexPath) as! ShopCVC
        cell.setupCell(shopItems[indexPath.row])
        cell.shopNowButton.tag = indexPath.row
        cell.shopNowButton.addTarget(self, action: #selector(ShopNowButtonPressed), for: UIControl.Event.touchUpInside)
        return cell
        
    }
    
    @objc func ShopNowButtonPressed(_ sender : UIButton) {
        if let vc = R.storyboard.fromShop.payVC() {
            vc.shopItem = shopItems[sender.tag]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width - 10), height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    
}
