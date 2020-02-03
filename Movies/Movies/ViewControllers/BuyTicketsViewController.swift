//
//  BuyTicketsViewController.swift
//  Movies
//
//  Created by Victor Ruiz on 2/3/20.
//  Copyright © 2020 Victor Ruiz. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class BuyTicketsViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://www.zocdoc.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
