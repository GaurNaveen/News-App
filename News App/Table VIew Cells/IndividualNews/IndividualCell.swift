//
//  IndividualCell.swift
//  News App
//
//  Created by Naveen Gaur on 19/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class IndividualCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    
    func setupCell(news: News,row:Int) {
        newsTitle.text = news.articles[row].title
        newsTitle.numberOfLines = 3
        configureImageView()
        loadImage(fetchedNews: news,row:row)
    }
    
    func configureImageView() {
        newsImage.contentMode = .scaleAspectFill
        newsImage.layer.masksToBounds = true
        newsImage.layer.cornerRadius = 5
        newsImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    func loadImage(fetchedNews: News,row:Int){
        // Unrap the optional
        if let imageurl = fetchedNews.articles[row ?? 0].urlToImage {
            newsImage.downloaded(from: imageurl)
        }
    }
}
