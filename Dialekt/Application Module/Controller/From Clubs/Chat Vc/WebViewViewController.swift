//
//  WebViewViewController.swift
//  Dialekt
//
//  Created by Macmini2021-vik on 29/09/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var cacelButton: UIButton!
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
       
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.cacelButton.roundViewCorner(radius: self.cacelButton.bounds.height/2)
        }
    }
    

    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
