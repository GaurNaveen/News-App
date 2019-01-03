//
//  HeadlinesCell.swift
//  News App
//
//  This files is used to setup the
//  table view cell. It is used to 
//
//  Created by Naveen Gaur on 31/12/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
class HeadlinesCell: UITableViewCell {
    // private let news: [News] = []
    // private let domains = ["wsj.com","nytimes.com"]
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsDescription: UILabel!
    
    @IBOutlet weak var newsView: UIView!
    
    /// This function is used to retrieve news from the wsj and nytimes.
    func getHealines(indexPath: IndexPath){
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.wsj(domain:"wsj.com"), completion: { (result) in
            
            switch result {
            case .success(let response):
                // If the response is ok , decode the json response.
                if response.statusCode == 200 {
                    // -- Add a guard over here, if the news api returns nil, we get news from other sources.
                    let news = try? JSONDecoder().decode(News.self, from: response.data)
                    self.removeOptional(news: news, indexPath: indexPath)
                    self.loadImage(news: news!, indexPath: indexPath)
                    self.diplayNewsTitle(news: news!)
                    self.newsView.dropShadow()
                } else {
                    // print the error
                    print(response.statusCode)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    /// This function is used to remove the optional from the news variable.
    func removeOptional(news : News?,indexPath: IndexPath) {
        if let value = news {
            print(value)
        }
    }
    
    /// Loads image in the image view.
    func loadImage(news: News,indexPath: IndexPath) {
        newsImage.contentMode = .scaleAspectFill;
        newsImage.layer.masksToBounds = true; // need this so that the image doesn't overflows.
        newsImage.load(url: URL(string: news.articles[indexPath.row].urlToImage)!)
        newsImage.layer.cornerRadius = 5
    }
    
    /// Used to display the title of the news below the image.
    func diplayNewsTitle(news: News) {
        newsDescription.text = news.articles[0].title
    }
}
