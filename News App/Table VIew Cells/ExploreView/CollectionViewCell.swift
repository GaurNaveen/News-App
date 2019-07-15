//
//  CollectionViewCell.swift
//  News App
//
//  Created by Naveen Gaur on 14/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    
    var headlines: News? = nil
    var row: Int = 0
    
    func setImage() {
        
        
        if let imageurl = headlines?.articles[row].urlToImage {
            newImage.downloaded(from: imageurl)
        }
        
        newImage.contentMode = .scaleAspectFit
        newImage.layer.masksToBounds = true
        newImage.layer.cornerRadius = 5
        newImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    func setTitle() {
        newsTitle.text = headlines?.articles[row].title
    }
    
    func getNews(category: String,indexPath:IndexPath) {
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.getNews(country: "us", category: "sports")) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    // Parse JSOn Response
                    self.row = indexPath.row
                    self.headlines = try! JSONDecoder().decode(News.self, from: response.data)
                    print(self.headlines)
                    self.setImage()
                    self.setTitle()
                }
            case .failure(_):
                print("Message")
            }
        }
    }
}


