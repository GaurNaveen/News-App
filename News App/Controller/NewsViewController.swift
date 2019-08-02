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
import SVProgressHUD
class NewsViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var webView: WKWebView!
    var url1 = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        displayProgressCircle(status: "Show")
        webView.navigationDelegate = self // Used to access the didFinishNavigation method.
        loadWebPage()
    }
    
    /// This function makes sure that when the user hits the back button
    /// and this view is not visible then it will stop the progress bar.
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    /// This function is used to load the webpage in the wkwebview
    /// so the user can read the full news article.
    func loadWebPage() {
        let url = URL(string: url1)
        guard url != nil else {return}
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    /// This function dismiss the progress bar when the WKWebview has finished loading the page.
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End")
        displayProgressCircle(status: "End")
    }
    
    /// This function is used to display a circular progress bar while news article that
    /// is selected the user is being loaded.
    ///
    /// - Parameter status: A string is passed which tells the function whether to show the
    ///                     progress bar or to dismiss it.
    func displayProgressCircle(status: String) {
        if status == "Show" {
            SVProgressHUD.show(withStatus: "Loading Article")
        } else {
            SVProgressHUD.dismiss()
        }
    }
}
