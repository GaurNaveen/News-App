//
//  ViewController.swift
//  News App
//
//  Created by Naveen Gaur on 22/12/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
import WebKit
var country = "us"
var domain = "wsj.com"
var domain2 = "nytimes.com"
var apiKey = "4eddeca93e8d4594bc9a605f7ef49319"
class ViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newsProvider = MoyaProvider<NewsService>()
//        newsProvider.request(.getNews(country: country), completion: { (result) in
//
//            switch result {
//            case .success(let response):
//               let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
//
//                let news = try? JSONDecoder().decode(News.self, from: response.data)
//               print(news as Any)
//            print(json)
//
//            case .failure(let error):
//                print(error)
//            }
//
//        })
//
        newsProvider.request(.getNews(country: "us", category: ""), completion: { (result) in
            switch result {
            case .success(let response):
                //let json = try! JSONSerialization.jsonObject(with: response.data, options: [])
                let json = try! JSONDecoder().decode(News.self, from: response.data)
                print(response.statusCode)
                print(json)
                
            case .failure(let error):
                print(error)
            }
            
            
        })
        
    }
    
    
}

