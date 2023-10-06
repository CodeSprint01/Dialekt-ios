//
//  Chat + table.swift
//  Dialekt
//
//  Created by Vikas saini on 21/05/21.
//

import Foundation
import UIKit
import SDWebImage
import PDFKit
import AVKit
import AVFoundation

extension ChatVC : UITableViewDelegate , UITableViewDataSource , UIDocumentInteractionControllerDelegate {
    
    
    //O FOR TEXT , 1 FOR IMAGE , 2 FOR PDF , 3 FOR VIDEO
    
    //MARK:- SETUP TABLE
    func setupTable(){
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: R.reuseIdentifier.senderTextTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.senderTextTVC.identifier)
        self.tableView.register(UINib(nibName: R.reuseIdentifier.mySideTextTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.mySideTextTVC.identifier)
        self.tableView.register(UINib(nibName: R.reuseIdentifier.mySideFileTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.mySideFileTVC.identifier)
        self.tableView.register(UINib(nibName: R.reuseIdentifier.mySideImageTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.mySideImageTVC.identifier)
        self.tableView.register(UINib(nibName: R.reuseIdentifier.senderFileTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.senderFileTVC.identifier)
        self.tableView.register(UINib(nibName: R.reuseIdentifier.sendImageTVC.identifier, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.sendImageTVC.identifier)
        self.tableView.reloadData()
      
    }
    
    //MARK:- NUMBER OF ROWS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        wholeChat.count
    }
    
    //MARK:- HEIGHT FOR ROW AT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    //MARK:- DID SELECT ROW AT
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thisItem = wholeChat[indexPath.row]
        if let message_type = thisItem.messageType {
            switch message_type {
            case 0 :  break//text
            case 1 :  //image
                let thisItem = wholeChat[indexPath.row]
                if let imageurlStr = thisItem.file , let ImageUrl = URL(string: IMAGE_BASE_URL+imageurlStr) {
                   if let vc = R.storyboard.fromClubs.showImageViewController() {
                       vc.imageURL = ImageUrl.absoluteString
                       self.present(vc, animated: true, completion: nil)
                    }
                }
            case 2 :  //pdf
                let thisItem = wholeChat[indexPath.row]
                if let imageurlStr = thisItem.file , let ImageUrl = URL(string: IMAGE_BASE_URL+imageurlStr) {
                   if let vc = R.storyboard.fromClubs.webViewViewController() {
                       vc.urlString = ImageUrl.absoluteString
                       self.present(vc, animated: true, completion: nil)
                    }
                }
            case 3 : //video
                let thisItem = wholeChat[indexPath.row]
                if let imageurlStr = thisItem.file , let ImageUrl = URL(string: IMAGE_BASE_URL+imageurlStr) {
                let player = AVPlayer(url: ImageUrl)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true) {
                    playerViewController.player!.play()
                }
                }
            default : break // Other
            }
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
    
    //MARK:- CELL FOR ROW AT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let thisItem = wholeChat[indexPath.row]
        if let message_type = thisItem.messageType {
        if thisItem.userID?.toInt() != UserDefaults.standard.integer(forKey: UD_USERID) {
            switch message_type {
            case 0 :  return setupTextSenderSide(thisItem, indexPath: indexPath)
            case 1 :  return setupImageOrVideoSenderSide(thisItem, indexPath: indexPath)
            case 2 :  return setupfileSenderSide(thisItem, indexPath: indexPath)
            case 3 :  return setupImageOrVideoSenderSide(thisItem, indexPath: indexPath)
            default : return UITableViewCell()
            }
           
        }else {
            switch message_type {
            case 0 : return setupTextMySide(thisItem, indexPath: indexPath)
            case 1 : return setupImageOrVideoMySide(thisItem, indexPath: indexPath)
            case 2 : return setupfileMySide(thisItem, indexPath: indexPath)
            case 3 : return setupImageOrVideoMySide(thisItem, indexPath: indexPath)
            default : return UITableViewCell()
            }
        }
        }
        return UITableViewCell()
        
    }
    
    //MARK:- SENDER SIDE FILE
    func setupfileSenderSide(_ thisItem : WholeChatModelDataClass , indexPath : IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.senderFileTVC.identifier, for: indexPath) as? SenderFileTVC {
            if let imageurlStr = thisItem.image , let ImageUrl = URL(string: IMAGE_BASE_URL+imageurlStr) {
                cell.senderImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.senderImage.sd_setImage(with: ImageUrl, placeholderImage: UIImage(named: R.image.dummyUser.name), options: [.highPriority], context: nil)
            }else {
                cell.senderImage.image = UIImage(named: R.image.dummyUser.name)
            }
            cell.messageLabel.text = "PDF FILE"//thisItem.message ?? "FILE"
            cell.messageLabel.clipsToBounds = true
            cell.messageLabel.layer.cornerRadius = 5
            DispatchQueue.main.async {
                cell.messageView.giveShadow(5)
            }
            if let dateOfMessage = (thisItem.createdAt ?? "").toDate() {
                cell.setupTime(dateOfMessage)
            }else {
                cell.timeLabel.text = "- - -"
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    //MARK:- MY SIDE FILE
    func setupfileMySide(_ thisItem : WholeChatModelDataClass , indexPath : IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mySideFileTVC.identifier, for: indexPath) as? MySideFileTVC {
            cell.messageLabel.text = "PDF FILE"//thisItem.message ?? "FILE"
            cell.messageLabel.clipsToBounds = true
            cell.messageLabel.layer.cornerRadius = 5
            DispatchQueue.main.async {
                cell.messageView.giveShadow(5)
            }
            if let dateOfMessage = (thisItem.createdAt ?? "").toDate() {
                cell.setupTime(dateOfMessage)
            }else {
                cell.timeLabel.text = "- - -"
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    //MARK:- SENDER SIDE IMAGE OR VIDEO
    func setupImageOrVideoSenderSide(_ thisItem : WholeChatModelDataClass , indexPath : IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sendImageTVC.identifier, for: indexPath) as? SendImageTVC {
            if let imageurlStr = thisItem.image , let ImageUrl = URL(string: IMAGE_BASE_URL+imageurlStr) {
                cell.ImageViewForThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.senderImage.sd_setImage(with: ImageUrl, placeholderImage: UIImage(named: R.image.dummyUser.name), options: [.highPriority], context: nil)
            }else {
                cell.senderImage.image = UIImage(named: R.image.dummyUser.name)
            }
            if thisItem.messageType == 1 {
                //it is an image
                cell.PlayImage.isHidden = true
                if let fileUrlString = thisItem.file , let url = URL(string: IMAGE_BASE_URL + fileUrlString) {
                    PrintToConsole("image url \(url)")
                    cell.ImageViewForThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.ImageViewForThumbnail.sd_setImage(with: url, placeholderImage: nil, options: [.highPriority], context: nil)
                }else {
                    cell.ImageViewForThumbnail.image = nil
                }
            }else {
                // it is a video
                if let fileUrlString = thisItem.file , let url = URL(string: IMAGE_BASE_URL + fileUrlString) {
                    getThumbnailImageFromVideoUrl(url: url) { (thumbImage) in
                        cell.ImageViewForThumbnail.image = thumbImage
                    }
                }else {
                    cell.ImageViewForThumbnail.image = nil
                }
                cell.PlayImage.isHidden = false
            }
            DispatchQueue.main.async {
                cell.ImageViewForThumbnail.giveShadow(5)
                cell.messageView.giveShadow(5)
            }
            if let dateOfMessage = (thisItem.createdAt ?? "").toDate() {
                cell.setupTime(dateOfMessage)
            }else {
                cell.timeLabel.text = "- - -"
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    //MARK:- MY SIDE IMAGE OR VIDEO
    func setupImageOrVideoMySide(_ thisItem : WholeChatModelDataClass , indexPath : IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mySideImageTVC.identifier, for: indexPath) as? MySideImageTVC {
            cell.ImageViewForThumbnail.clipsToBounds = true
            cell.ImageViewForThumbnail.layer.cornerRadius = 5
            if thisItem.messageType == 1 {
                //it is an image
                cell.PlayImage.isHidden = true
                if let fileUrlString = thisItem.file , let url = URL(string: IMAGE_BASE_URL + fileUrlString) {
                    cell.ImageViewForThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
                    PrintToConsole("image url \(url)")
                    cell.ImageViewForThumbnail.sd_setImage(with: url, placeholderImage: nil, options: [.highPriority], context: nil)
                }else {
                    cell.ImageViewForThumbnail.image = nil
                }
            }else {
                // it is a video
                if let fileUrlString = thisItem.file , let url = URL(string: IMAGE_BASE_URL + fileUrlString) {
                    getThumbnailImageFromVideoUrl(url: url) { (thumbImage) in
                        cell.ImageViewForThumbnail.image = thumbImage
                    }
                }else {
                    cell.ImageViewForThumbnail.image = nil
                }
                cell.PlayImage.isHidden = false
            }
            DispatchQueue.main.async {
                cell.messageView.giveShadow(5)
            }
            if let dateOfMessage = (thisItem.createdAt ?? "").toDate() {
                cell.setupTime(dateOfMessage)
            }else {
                cell.timeLabel.text = "- - -"
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    //MARK :- SENDER SIDE TEXT
    func setupTextSenderSide(_ thisItem : WholeChatModelDataClass , indexPath : IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.senderTextTVC.identifier, for: indexPath) as? SenderTextTVC {
            if let imageurlStr = thisItem.image , let ImageUrl = URL(string: IMAGE_BASE_URL+imageurlStr) {
                cell.senderImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.senderImage.sd_setImage(with: ImageUrl, placeholderImage: UIImage(named: R.image.dummyUser.name), options: [.highPriority], context: nil)
            }else {
                cell.senderImage.image = UIImage(named: R.image.dummyUser.name)
            }
            cell.messageLabel.text = thisItem.message ?? "FILE"
            DispatchQueue.main.async {
                cell.messageView.giveShadow(5)
            }
            if let dateOfMessage = (thisItem.createdAt ?? "").toDate() {
                cell.setupTime(dateOfMessage)
            }else {
                cell.timeLabel.text = "- - -"
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    //MARK :- MY SIDE TEXT
    func setupTextMySide(_ thisItem : WholeChatModelDataClass , indexPath : IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mySideTextTVC.identifier, for: indexPath) as? MySideTextTVC {
            cell.messageLabel.text = thisItem.message ?? "FILE"
            DispatchQueue.main.async {
                cell.messageView.giveShadow(5)
            }
            if let dateOfMessage = (thisItem.createdAt ?? "").toDate() {
                cell.setupTime(dateOfMessage)
            }else {
                cell.timeLabel.text = "- - -"
            }
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
}
