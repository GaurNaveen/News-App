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
import Kingfisher
class HeadlinesCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsView: UIView!
    
    /// This function is used to setup the table view cell with the news.
    /// It calls methods that will load the image , dispplay the title of
    /// and adds a shadow effect on the newsView.
    ///
    /// - Parameters:
    ///   - news: It is the news object that is loaded from the api. It
    ///           contains info about the news.
    ///   - indexPath: This is the index path of each table view cell.
    func displayNews(news: News?,indexPath: IndexPath) {
        configureImageView()
        loadImage(news: news!, indexPath: indexPath)
        diplayNewsTitle(news: news!, indexPath: indexPath)
        newsView.dropShadow()
    }
    
    /// This is used to setup the image view. It sets the content mode for the
    /// image view and also rounds of the corners at the top.
    func configureImageView() {
        newsImage.contentMode = .scaleAspectFill;
        newsImage.layer.masksToBounds = true; // need this so that the image doesn't overflows.
        // Set rounded corners on the image view.
        newsImage.layer.cornerRadius = 5
        // This line helps to round the top 2 corners of the image view.
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
        // Unwrap the optional
        if let imageurl = news.articles[indexPath.row].urlToImage {
            let url = URL(string: imageurl)
            newsImage.kf.setImage(with: url)
        }
    }
    
    /// Used to display the title of the news below the image.
    ///
    /// - Parameters:
    ///   - news: It is the news object that is loaded from the api. It
    ///           contains info about the news.
    ///   - indexPath: This is the index path of each table view cell.
    func diplayNewsTitle(news: News,indexPath: IndexPath) {

        newsDescription.text = news.articles[indexPath.row].title
    }
    
    /// It will prevent the change of data while scrolling.
    /// In this method only the alpha or other appearence values of cell should be done.
    override func prepareForReuse() {
    }
}
