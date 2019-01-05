//
//  NewsViewController.swift
//  News App
//
//  This view will contain a web view
//  which will load the news for the user
//  to read.
//
//  Created by Naveen Gaur on 3/1/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import WebKit
class NewsViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    var url1 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebPage()
    }
    
    /// This function is used to load the webpage in the wkwebview
    /// so the user can read the full news article.
    func loadWebPage() {
        let url = URL(string: url1)
        guard url != nil else {return}
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
