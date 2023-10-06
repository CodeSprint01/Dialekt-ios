//
//  File.swift
//  Dialekt
//
//  Created by Vikas saini on 24/05/21.
//

import Foundation
import UIKit


extension TestProgressContainer1VC : UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    
    func setupCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: R.reuseIdentifier.testProgress1CVC.identifier, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.testProgress1CVC.identifier)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewDidLayoutSubviews()
        return textArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.testProgress1CVC.identifier, for: indexPath) as! TestProgress1CVC
        cell.backView.giveShadow()
        cell.labelForText.text = textArray[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        crossView.isHidden = false
        finalText = finalText + " " + textArray[indexPath.row]
        tfText.text = finalText
        textArray.remove(at: indexPath.row)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

