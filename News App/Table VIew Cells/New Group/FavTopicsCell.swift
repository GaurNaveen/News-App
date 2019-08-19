//
//  FavTopicsCell.swift
//  News App
//
//  Created by Naveen Gaur on 17/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Kingfisher
class FavTopicsCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    func setupNewsTitle(newsTitle: String) {
        titleLabel.text = newsTitle
    }
    
    func setupnewsImage(){
        newsImage.layer.masksToBounds = true
        newsImage.layer.cornerRadius = 5
        newsImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    //  MARK: - Load Image from URL.
    /// Loads image in the image view for each cell.The image when loaded is cached.
    /// This is because UITableView reuses cells. Loading them without caching will cause the
    /// async requests to return at different time and mess up the order.
    ///
    /// - Parameters:
    ///   - news: It is the news object that is loaded from the api. It
    ///           contains info about the news.
    ///   - indexPath: This is the index path of each table view cell.
    func loadImage(news: News,indexPath: IndexPath) {
        setupnewsImage()
        
        // Unwrap the optional
        if let imageurl = news.articles[indexPath.row].urlToImage {
            let url = URL(string: imageurl)
            newsImage.kf.setImage(with: url)
        }
    }
}
