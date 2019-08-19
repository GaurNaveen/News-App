//
//  TestViewController.swift
//  News App
//
//  Created by Naveen Gaur on 19/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let jsonUrlString = "https://newsapi.org/v2/everything?q=bitcoin&from=2019-08-10&sortBy=publishedAt&apiKey=4eddeca93e8d4594bc9a605f7ef49319"
        
        guard let url = URL(string: jsonUrlString) else {return}
        print("hello")
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else{return}
            print("hello")
            let dataAsString = String(data: data, encoding: .utf8)
            print(dataAsString)
            
            do {
                let course = try JSONDecoder().decode(News.self, from: data)
                print(course.articles.count)
                
            } catch let jsonErr {
                
            }
        }.resume()
    }
    

}
