//
//  ShowImageViewController.swift
//  Dialekt
//
//  Created by Macmini2021-vik on 29/09/21.
//

import UIKit
import SDWebImage

class ShowImageViewController: UIViewController {

    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let url = URL(string: imageURL) {
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
           imageView.sd_setImage(with: url, placeholderImage: nil, options: [.highPriority], context: nil)
        }else {
           imageView.image = nil
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.saveButton.roundViewCorner(radius: self.saveButton.bounds.height/2)
            self.cancelButton.roundViewCorner(radius: self.cancelButton.bounds.height/2)
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
    }
    
    //MARK: - Add image to Library
       @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
           if let error = error {
               // we got back an error!
               Toast.show(message: "Error While Saving : \(error.localizedDescription)", controller: self)
           } else {
               Toast.show(message: "Saved To Gallary.", controller: self)
           }
       }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
  

}
