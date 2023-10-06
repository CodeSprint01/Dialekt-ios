//
//  ChatVC.swift
//  Dialekt
//
//  Created by Vikas saini on 20/05/21.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ChatVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var BottomView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tfMessage: EmojiTextField!
    @IBOutlet weak var clubNameLabel: UILabel!
    @IBOutlet weak var sendView: UIView!
    
    var ClubID = 0
    var clubName = ""
    var wholeChat = [WholeChatModelDataClass]()
    
    //MARK: - CONSTANTS AND VARIABLES
    var DummyText = [String]()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        tfMessage.delegate = self
        setupTable()
        clubNameLabel.text = clubName
    }
    
    
    //MARK: - VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topViewHeight.constant = self.view.safeAreaInsets.top + 75
        topView.addBottomRoundedEdge(desiredCurve: 1.5)
        sendView.roundViewCorner(radius: sendView.bounds.height / 2)
        BottomView.giveShadow(0, CGSize(width: 0.0, height: -5))
        self.view.layoutIfNeeded()
    }
    
    //MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiCallForGetChat()
    }
    
    //MARK: - BUTTON ACTIONS
    
    @IBAction func moreButtonAction(_ sender: Any) {
        Toast.show(message: "More", controller: self)
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendMessageButton(_ sender: Any) {
        sendMessage()
    }
    
    @IBAction func emojiButtonAction(_ sender: Any) {
        tfMessage.reloadInputViews()
        if !tfMessage.isFirstResponder {
            tfMessage.becomeFirstResponder()
        }
    }
    
    //MARK: - openDocumentPicker
    func openDocumentPicker(){
        let docMenu = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        docMenu.delegate = self
        docMenu.modalPresentationStyle = .formSheet
        self.present(docMenu, animated: true, completion: nil)
    }
    
    
    @IBAction func attachmentButtonAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Dialekt", message: "Choose an option", preferredStyle: UIAlertController.Style.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Image/Video", style: UIAlertAction.Style.default, handler: { a in
            MediaPicker.shared.showAttachmentActionSheet(vc: self)
            MediaPicker.shared.imagePickedBlock = { image in
                PrintToConsole("image \(image)")
                self.apiCallForSendingfile(image.pngData()!, fileType: .Image)
            }
            MediaPicker.shared.filePickedBlock = { URLL in
                PrintToConsole("URLL \(URLL)")
                do {
                    let data = try Data(contentsOf: URLL)
                    self.apiCallForSendingfile(data, fileType: .Video)
                }
                catch let err {
                    PrintToConsole("error \(err.localizedDescription)")
                }
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Pdf file", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.openDocumentPicker()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func sendMessage(){
        let text = tfMessage.text?.trimmed() ?? ""
        if text != ""
        {
            apiCallForSendingMessage(text)
        }
    }
}


extension ChatVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfMessage.resignFirstResponder()
        sendMessage()
        return true
    }
}


//MARK: - FILE IMPORT DELEGATE
extension ChatVC:  UIDocumentPickerDelegate{
    
    //MARK:- Document Picker Delegate
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        PrintToConsole("URLL \(url)")
        do {
            let data = try Data(contentsOf: url)
            self.apiCallForSendingfile(data, fileType: .Pdf)
        } catch let err {
            PrintToConsole("error \(err)")
        }
    }
    
    // MARK: - documentPickerWasCancelled
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
}
