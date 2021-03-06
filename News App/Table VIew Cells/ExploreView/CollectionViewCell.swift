//
//  CollectionViewCell.swift
//  News App
//
//  Created by Naveen Gaur on 14/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
import Kingfisher
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
        //addTap()
    }
    
    func setImage() {
        if let imageurl = headlines?.articles[row].urlToImage {
            let url = URL(string: imageurl)
            newImage.kf.setImage(with: url)
        }
        
        newImage.contentMode = .scaleAspectFit
        newImage.layer.masksToBounds = true
        newImage.layer.cornerRadius = 5
        newImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    func setTitle() {
        newsTitle.text = headlines?.articles[row].title
    }
    
    func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        newImage.isUserInteractionEnabled = true
        newImage.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("Lil")
    }
}
