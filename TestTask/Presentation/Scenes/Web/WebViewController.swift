//
//  ViewController.swift
//  TestTask
//
//  Created by Илья on 18/11/2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private var webView: WKWebView!
    
    var urlString = String()
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: urlString) {
            self.webView.load(URLRequest(url: url))
            self.webView.allowsBackForwardNavigationGestures = true
        }
    }

}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate { }
