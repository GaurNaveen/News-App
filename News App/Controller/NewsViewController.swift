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
    var url = "https://www.theverge.com/2019/1/3/18166399/iphone-android-apple-samsung-smartphone-sales-peak"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.load(URLRequest(url: URL(string: url)!))
    
    }

}
