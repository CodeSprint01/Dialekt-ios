//
//  TestProgressContainer3VC.swift
//  Dialekt
//
//  Created by Vikas saini on 24/05/21.
//

import UIKit

class TestProgressContainer3VC: UIViewController {

    
    //MARK:- OUTLETS
//    @IBOutlet weak var Button1: UIButton!
//    @IBOutlet weak var Button2: UIButton!
//    @IBOutlet weak var stackView: UIStackView!
//    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var selectedIndex = 123456
    var thisData : QuestionlistingModelDataClass?
    //MARK:- VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        questionlabel.text = thisData?.question ?? ""
     setupCollection()
    }
    
    
    //MARK:- VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupCollection(){
        self.tableView.register(UINib(nibName: R.reuseIdentifier.questionOptionWithoutImageTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.questionOptionWithoutImageTVC.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.reloadData()
        
    }
    
//
//
//    @IBAction func Button3Pressed(_ sender: Any) {
//        self.Button3.backgroundColor = MainColor
//        self.Button3.setTitleColor(.white, for: .init())
//        self.Button2.backgroundColor = UIColor.white
//        self.Button2.setTitleColor(.black, for: .init())
//        self.Button1.backgroundColor = UIColor.white
//        self.Button1.setTitleColor(.black, for: .init())
//    }
//
//    @IBAction func IntermediatePressed(_ sender: Any) {
//        self.Button3.backgroundColor = UIColor.white
//        self.Button3.setTitleColor(.black, for: .init())
//        self.Button2.backgroundColor = MainColor
//        self.Button2.setTitleColor(.white, for: .init())
//        self.Button1.backgroundColor = UIColor.white
//        self.Button1.setTitleColor(.black, for: .init())
//    }
//
//    @IBAction func beginerPressed(_ sender: Any) {
//        self.Button3.backgroundColor = UIColor.white
//        self.Button3.setTitleColor(.black, for: .init())
//        self.Button2.backgroundColor = UIColor.white
//        self.Button2.setTitleColor(.black, for: .init())
//        self.Button1.backgroundColor = MainColor
//        self.Button1.setTitleColor(.white, for: .init())
//    }

    
}


extension TestProgressContainer3VC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        thisData?.option?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.questionOptionWithoutImageTVC.identifier, for: indexPath) as? QuestionOptionWithoutImageTVC {
            cell.selectionStyle = .none
            cell.configureCell(selectedIndex == indexPath.row , text : thisData?.option?[indexPath.row].option ?? "-" )
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    
}
