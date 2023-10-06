//
//  TestProgressContainer4VC.swift
//  Dialekt
//
//  Created by Vikas saini on 24/05/21.
//

import UIKit

class TestProgressContainer4VC: UIViewController {

    //MARK: - OUTLETS

    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topLabel: UILabel!
    
    var selectedIndex = 123456
    var thisData : QuestionlistingModelDataClass?
    var topLabelText: String?
    
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        if topLabelText != nil {
            topLabel.text = topLabelText
        }
        questionlabel.text = thisData?.question ?? ""
        setupCollection()
    }
    
    //MARK: - VIEW DID LAYOUT SUBVIEW
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
}

//MARK: - TableView Delegate and Datasource
extension TestProgressContainer4VC : UITableViewDelegate , UITableViewDataSource {
    
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
