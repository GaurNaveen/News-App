//
//  SearchCell.swift
//  News App
//
//  Created by Naveen Gaur on 9/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    
    var fetchedNews:News?
    var row:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func diplayNews(news: News?,indexPath: IndexPath) {
        print("hi")
        configureImageView()
        fetchedNews = news
        row = indexPath.row
        loadImage()
        
    }
    
    func configureImageView() {
        newsImage.layer.cornerRadius = 5
        newsImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    func loadImage(){
        // Unrap the optional
        if let imageurl = fetchedNews?.articles[row ?? 0].urlToImage {
            newsImage.downloaded(from: imageurl)
        }
        print("Oho")
    }
    
}
