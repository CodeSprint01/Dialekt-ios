//
//  HomeLevelsViewController.swift
//  Dialekt
//
//  Created by Vikas saini on 12/05/21.
//

import UIKit

class HomeLevelsViewController: UIViewController {

    
    //MARK:- OUTLETS
    @IBOutlet weak var PlayView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- CONSTANTS AND VARIABLES
    var allHomeLevelData = [HomeLevelsModelDataClass]()
    
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayView.layer.borderWidth = 5
        PlayView.layer.borderColor = UIColor.white.cgColor
        PlayView.giveShadow(PlayView.bounds.height / 2)
       
    }
    
    //MARK:- SETUP TABLE METHOD
    func setupTable(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.reuseIdentifier.homeTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.homeTVC.identifier)
        tableView.register(UINib(nibName: R.reuseIdentifier.homeTVHeaderCell.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.homeTVHeaderCell.identifier)
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    //MARK:- VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiCallForHomeLevel()
    }

    //MARK:- BUTTON ACTIONS
    @IBAction func PlayButtonClicked(_ sender: Any) {
        if let vc = R.storyboard.playGame.createOrJoinGroupVC() {
            self.parent?.navigationController?.pushViewController(vc, animated: true)
        }
    }


}



//MARK:- TableView Delegate and datasource
extension HomeLevelsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allHomeLevelData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeTVC.identifier, for: indexPath) as? HomeTVC {
//            cell.configureCollectionView(indexPath.section == 0 ? 0 : 123456 , gameType: allHomeLevelData[indexPath.section].gameType ?? [])
            cell.configureCollectionView( gameType: allHomeLevelData[indexPath.section].gameType ?? [])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let HeaderCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.homeTVHeaderCell.identifier) as? HomeTVHeaderCell {
            HeaderCell.levelLabel.text = allHomeLevelData[section].name ?? "---"
            DispatchQueue.main.async {
                HeaderCell.levelLabel.roundViewCorner(radius: 6)
            }
            return HeaderCell.contentView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if allHomeLevelData[indexPath.section].gameType?.count == 0 {
            return 0
        }else {
        return tableView.bounds.height / 2
        }
    }
    
    
}
