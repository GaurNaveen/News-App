//
//  util.swift
//  News App
//
//  Created by Naveen Gaur on 18/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import Foundation
import Moya

class Util {
    var headlines: News? = nil
    func getNews() {
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.getNews(country: "us", category: "sports")) { (result) in
            switch result {
                
            case .success(let response):
                self.headlines = try! JSONDecoder().decode(News.self, from: response.data)
                
            case .failure(_):
                print("message")
            }
        }
    }
    
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        let result = formatter.string(from: date)
        
        return result
    }
}
