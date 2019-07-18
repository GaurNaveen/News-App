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
    @IBOutlet weak var titleLabel: UILabel!
    
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
        configureImageView()
        fetchedNews = news
        row = indexPath.row
        loadImage()
        configureTitleLabel()
    }
    
    func configureImageView() {
        newsImage.contentMode = .scaleAspectFill
        newsImage.layer.masksToBounds = true
        newsImage.layer.cornerRadius = 5
        newsImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    func configureTitleLabel(){
        titleLabel.text = fetchedNews?.articles[row ?? 0].title
    }
    
    func loadImage(){
        // Unrap the optional
        if let imageurl = fetchedNews?.articles[row ?? 0].urlToImage {
            newsImage.downloaded(from: imageurl)
        }
    }
}
