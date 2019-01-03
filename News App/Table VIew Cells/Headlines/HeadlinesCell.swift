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
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsDescription: UILabel!
    
    @IBOutlet weak var newsView: UIView!
    
    func displayNews(news: News?,indexPath: IndexPath) {
        removeOptional(news: news, indexPath: indexPath)
        loadImage(news: news!, indexPath: indexPath)
        diplayNewsTitle(news: news!, indexPath: indexPath)
        newsView.dropShadow()
    }
    
    /// This function is used to remove the optional from the news variable.
    func removeOptional(news : News?,indexPath: IndexPath) {
        if let value = news {
            print(value)
        }
    }
    
    /// Loads image in the image view for each cell.
    func loadImage(news: News,indexPath: IndexPath) {
        newsImage.contentMode = .scaleAspectFill;
        newsImage.layer.masksToBounds = true; // need this so that the image doesn't overflows.
        newsImage.load(url: URL(string: news.articles[indexPath.row].urlToImage!)!)
        newsImage.layer.cornerRadius = 5
    }
    
    /// Used to display the title of the news below the image.
    func diplayNewsTitle(news: News,indexPath: IndexPath) {
        newsDescription.text = news.articles[indexPath.row].title
    }
}
