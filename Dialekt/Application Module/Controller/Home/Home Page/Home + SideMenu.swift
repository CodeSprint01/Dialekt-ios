//
//  Home + SideMenu.swift
//  Dialekt
//
//  Created by Vikas saini on 12/05/21.
//

import Foundation
import UIKit
import SDWebImage

extension HomeViewController : UITableViewDelegate , UITableViewDataSource  {
    
    //MARK: - SETUP SIDE MENU

    func setupViewForSideMenu(){
        
        DispatchQueue.main.async {
            self.personNameLabel.text = UserDefaults.standard.string(forKey: UD_NAME) ?? ""
            self.personImageView.tintColor = .darkGray
            self.personImageView.sd_setImage(with: URL(string: IMAGE_BASE_URL + (UserDefaults.standard.string(forKey: UD_USERIMAGE) ?? "")), placeholderImage: #imageLiteral(resourceName: "DummyUser"), options: [.highPriority], context: nil)
            self.logoutButton.giveShadow()
            self.inviteButton.giveShadow()
            self.personImageView.roundImgCorner(radius: self.personImageView.bounds.height / 2)
            self.editImageView.roundViewCorner(radius: self.editImageView.bounds.height / 2)
            self.whiteView.roundCorners(corners: [.topRight , .bottomRight], radius: 15)
            self.BlackView.backgroundColor = .clear
        }
        
        sideMenuTableView.register(UINib(nibName: R.reuseIdentifier.sideMenuTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.sideMenuTVC.identifier)
        sideMenuTableView.delegate = self
        sideMenuTableView.separatorStyle = .none
        sideMenuTableView.dataSource = self
        balckViewButton.addTarget(self, action: #selector(closeSideMenuGesture), for: .touchUpInside)
    }
    
    //MARK: - CLOSE SIDE MENU
    @objc func closeSideMenuGesture(){
        self.trailingContstraintOfSideMenu.constant = UIScreen.main.bounds.width 
        UIView.animate(withDuration: 0.65) {
            self.view.layoutIfNeeded()
            self.BlackView.backgroundColor = .clear
        }
    }
    
    //MARK: - TABLE VIEW DELEGATE AND DATASOURCE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sideMenuTVC.identifier, for: indexPath) as? SideMenuTVC {
            cell.label.text = SideMenuText[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PrintToConsole("index \(indexPath.row)")
        switch indexPath.row {
        case 0 :
            if let window = GetWindow(), let vc = R.storyboard.home.homeViewController() {
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        case 1 :
            if let vc = R.storyboard.fromSideMenu.dailyGoalParameterVC() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 2 :
            if let vc = R.storyboard.fromSideMenu.streakVC() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 3 :
            if let vc = R.storyboard.fromSideMenu.dialektTokenVCFromSideMenu() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 4 :
            if let vc = R.storyboard.fromSideMenu.dailyGoalsViewController() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 5 :
            if let vc = R.storyboard.fromSideMenu.newchatBotVC () {
//            if let vc = R.storyboard.fromSideMenu.chatBotViewController() {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default : break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    
    //MARK: - Go To First Page
    func goToFirstPage() {
        if let window = GetWindow(), let vc = R.storyboard.auth.getStartedViewController() {
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        window.rootViewController = nav
        window.makeKeyAndVisible()
        }
    }
}
