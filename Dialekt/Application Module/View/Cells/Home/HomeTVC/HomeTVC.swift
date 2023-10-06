//
//  HomeTVC.swift
//  Dialekt
//
//  Created by Vikas saini on 17/05/21.
//

import UIKit


class HomeTVC: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var CurrentLevel = 123456
    var thisGame = [GameType]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.baseView.giveShadow()
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCollectionView(gameType : [GameType]) {
//        func configureCollectionView(_ Selection: Int = 123456 , gameType : [GameType]) {
        self.thisGame = gameType
//        CurrentLevel = Selection
        DispatchQueue.main.async {
            self.collectionView.delegate = self
            self.collectionView.dataSource  = self
            self.collectionView.reloadData()
            self.collectionView.register(UINib(nibName: R.reuseIdentifier.homeCVC.identifier, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.homeCVC.identifier)
        }
    }
    
}


extension HomeTVC : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        thisGame.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.homeCVC.identifier, for: indexPath) as! HomeCVC
        cell.label.text = thisGame[indexPath.row].gameName ?? "--"
        if thisGame[indexPath.row].isactive_count == 1 {
//            if CurrentLevel == indexPath.item {
            cell.tickView.isHidden = false
            cell.innerView.backgroundColor = MainColor
        }else {
            cell.tickView.isHidden = true
            cell.innerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        }
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 3, height: collectionView.bounds.width / 3 + 20)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if thisGame[indexPath.row].isactive_count == 1 {
            NotificationCenter.default.post(name: NSNotification.Name.init("GoPlay"), object: nil, userInfo: ["id": thisGame[indexPath.row].id ?? 0])
        }
    }
    
}
