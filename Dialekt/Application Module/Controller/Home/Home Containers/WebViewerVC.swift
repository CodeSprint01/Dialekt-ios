//
//  WebViewerVC.swift
//  Dialekt
//
//  Created by iApp on 18/08/22.
//

import UIKit
import WebKit

class WebViewerVC: UIViewController, WKUIDelegate {

    @IBOutlet var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!

    var fileUrl: URL? = nil
    var titleText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = titleText
        webView.navigationDelegate = self
        let request = URLRequest(url: fileUrl!)
        webView.load(request)
        webView.isOpaque = false

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            self.topViewHeight.constant = self.view.safeAreaInsets.top + 75
        DispatchQueue.main.asyncAfter(deadline: .now()+0.01) {
            self.topView.addBottomRoundedEdge(desiredCurve: 1.5)
        }

    }

    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension WebViewerVC : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        startAnimating(self.view)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopAnimating()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        stopAnimating()
        print(error)
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopAnimating()
        print(error)
    }
}
