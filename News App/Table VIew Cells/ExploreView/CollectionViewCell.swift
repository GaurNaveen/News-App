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
    
    func setNews(headlines:News,row: Int) {
        self.headlines = headlines
        self.row = row
        setImage()
        setTitle()
    }
    
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
}



