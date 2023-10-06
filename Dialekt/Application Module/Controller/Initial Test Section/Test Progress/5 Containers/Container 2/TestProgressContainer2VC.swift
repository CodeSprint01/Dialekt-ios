//
//  TestProgressContainer2VC.swift
//  Dialekt
//
//  Created by Vikas saini on 24/05/21.
//

import UIKit
import Foundation

class TestProgressContainer2VC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK:- CLASS VARIABLES AND CONSTANT
    var selectedIndex = 123456 // the value will be updated in didSelectItemAt
    var thisData : QuestionlistingModelDataClass?
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = thisData?.question ?? ""
        setupCollection()
    }
    
}



extension TestProgressContainer2VC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    func setupCollection(){
        collectionView.register(UINib(nibName: R.reuseIdentifier.selectCityCVC.identifier, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.selectCityCVC.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thisData?.option?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.selectCityCVC.identifier, for: indexPath) as? SelectCityCVC {
            cell.backView.layer.borderColor = MainColor.cgColor
            
            PrintToConsole("\(IMAGE_BASE_URL + (thisData?.option?[indexPath.row].image ?? ""))")
            cell.imageview.sd_setImage(with: URL(string: IMAGE_BASE_URL + (thisData?.option?[indexPath.row].image ?? "")), placeholderImage: #imageLiteral(resourceName: "city"), options: [.highPriority], context: nil)
            cell.label.text = thisData?.option?[indexPath.row].option ?? ""
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
            self.collectionView.reloadData()
        }
    }
    
    
}




