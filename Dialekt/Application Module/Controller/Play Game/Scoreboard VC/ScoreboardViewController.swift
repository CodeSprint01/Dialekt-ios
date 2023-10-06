//
//  ScoreboardViewController.swift
//  Dialekt
//
//  Created by Techwin on 01/07/21.
//

import UIKit

class ScoreboardViewController: UIViewController {

    @IBOutlet weak var Rank3View: UIView!
    @IBOutlet weak var Rank1View: UIView!
    @IBOutlet weak var Rank2View: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Person3Points: UILabel!
    @IBOutlet weak var Person1Points: UILabel!
    @IBOutlet weak var Person3Name: UILabel!
    @IBOutlet weak var Person2Points: UILabel!
    @IBOutlet weak var person2Name: UILabel!
    @IBOutlet weak var person1Name: UILabel!
    @IBOutlet weak var Person3Imageview: UIImageView!
    @IBOutlet weak var whiteView: UIView!
    @IBOutlet weak var Person2ImageView: UIImageView!
    @IBOutlet weak var Person1ImageView: UIImageView!
    
    var groupID = ""
    var gameID = ""
    var ALlUserPointsData =  [OtherUserGamePointsModelDataClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
       
    }
    
     //MARK:- SETUP UI
    func setupUi(){
        backButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backButton.addTarget(self, action: #selector(DismissView), for: UIControl.Event.touchUpInside)
        whiteView.roundViewCorner(radius: 20)
        self.apiCallForAllUsersPoints()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.Person1ImageView.roundViewCorner(radius: self.Person1ImageView.bounds.height / 2)
            self.Person2ImageView.roundViewCorner(radius: self.Person2ImageView.bounds.height / 2)
            self.Person3Imageview.roundViewCorner(radius: self.Person3Imageview.bounds.height / 2)
        }
    }
    
    
    @objc func DismissView(){
     
            if let window = GetWindow(), let vc = R.storyboard.home.homeViewController() {
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            window.rootViewController = nav
            window.makeKeyAndVisible()
            }
      
    }
    
}


extension ScoreboardViewController : UITableViewDelegate  , UITableViewDataSource {
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: R.reuseIdentifier.userScoreBoardTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.userScoreBoardTVC.identifier)
        self.tableView.reloadData()
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ALlUserPointsData.count > 3 ? (ALlUserPointsData.count-3) : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userScoreBoardTVC.identifier, for: indexPath) as? UserScoreBoardTVC {
            let thisUser = ALlUserPointsData[indexPath.row]
            if UserDefaults.standard.integer(forKey: UD_USERID) == thisUser.userID?.toInt(){
                cell.backView.backgroundColor = R.color.pinkishColor()
                cell.pointsLabel.backgroundColor = .white
            }else {
                cell.backView.backgroundColor = .white
                cell.pointsLabel.backgroundColor = R.color.pinkishColor()
            }
            DispatchQueue.main.async {
                cell.personImageView.roundImgCorner(radius: cell.personImageView.bounds.height / 2)
            }
            cell.nameLabel.text = thisUser.name ?? "-"
            cell.pointsLabel.text = thisUser.point ?? "-"
            cell.numberLabel.text = (indexPath.row+4).toString
            if let imageUrl = thisUser.image {
                cell.personImageView.sd_setImage(with: URL(string: IMAGE_BASE_URL + imageUrl), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
            }else{
                cell.personImageView.image = #imageLiteral(resourceName: "DummyUser")
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       50// UITableView.automaticDimension
    }
    
    
    func setupTopData(){
        if ALlUserPointsData.count == 0 {
            Rank1View.alpha = 0.5
            Rank2View.alpha = 0.5
            Rank3View.alpha = 0.5
        }else if ALlUserPointsData.count == 1 {
            Rank2View.alpha = 0.5
            Rank3View.alpha = 0.5
            setupPerson1()
        }else if ALlUserPointsData.count == 2 {
            setupPerson1()
            setupPerson2()
            Rank3View.alpha = 0.5
        }else {
            setupPerson1()
            setupPerson2()
            setupPerson3()
        }
    }
    
    
    func setupPerson1(){
        self.person1Name.text = ALlUserPointsData[0].name ?? ""
        self.Person1Points.text = ALlUserPointsData[0].point ?? ""
        if let imageUrl = ALlUserPointsData[0].image {
            self.Person1ImageView.sd_setImage(with: URL(string: IMAGE_BASE_URL + imageUrl), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
        }else{
            self.Person1ImageView.image = #imageLiteral(resourceName: "DummyUser")
        }
    }
    func setupPerson2(){
        self.person2Name.text = ALlUserPointsData[1].name ?? ""
        self.Person2Points.text = ALlUserPointsData[1].point ?? ""
        if let imageUrl = ALlUserPointsData[1].image {
            self.Person2ImageView.sd_setImage(with: URL(string: IMAGE_BASE_URL + imageUrl), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
        }else{
            self.Person2ImageView.image = #imageLiteral(resourceName: "DummyUser")
        }
    }
    func setupPerson3(){
        self.Person3Name.text = ALlUserPointsData[2].name ?? ""
        self.Person3Points.text = ALlUserPointsData[2].point ?? ""
        if let imageUrl = ALlUserPointsData[2].image {
            self.Person3Imageview.sd_setImage(with: URL(string: IMAGE_BASE_URL + imageUrl), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
        }else{
            self.Person3Imageview.image = #imageLiteral(resourceName: "DummyUser")
        }
    }
    
    
}


extension ScoreboardViewController  {
    
    
    //MARK:- API CALL FOR Other user points
    func apiCallForAllUsersPoints(){
        
        let params = [ "group_id":"\(groupID)", "game_id" : "\(gameID)"]
        PrintToConsole("i am here \(groupID) \(gameID)")
        ApiManager.shared.Request(type: OtherUserGamePointsModel.self, methodType: .Post, url: BASE_URL + GET_ALL_USER_POINT_API , parameter: params) { (error, response, message, statusCode) in
            if statusCode == 200 {
                if let data = response?.data {
                    PrintToConsole("response of alluserPoinst api \(data)")
                    DispatchQueue.main.async {
                    self.ALlUserPointsData = data
                    self.setupTableView()
                    self.setupTopData()
                    }
                }
            }else {
                if let msgStr = message {
                    Toast.show(message: msgStr, controller: self)
                }else {
                    Toast.show(message: SOMETHING_WENT_WRONG, controller: self)
                }
            }
        }
    }
}
