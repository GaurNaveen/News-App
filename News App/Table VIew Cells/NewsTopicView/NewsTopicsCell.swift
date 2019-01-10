//
//  NewsTopicsCell.swift
//  News App
//
//  This file is used to configure the NewsTopicController
//  table view cell that will be used to show the user wide
//  range of topics that they can find news on.
//
//  Created by Naveen Gaur on 8/1/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class NewsTopicsCell: UITableViewCell {

    @IBOutlet weak var topicSelectionView1: UIView!
    
    @IBOutlet weak var topicSelectionView2: UIView!
    
    func setupSelectionViews() {
        topicSelectionView1.backgroundColor = getColor(colorName: "customRed")
        topicSelectionView2.backgroundColor = getColor(colorName: "lightBlue")
    }
    
    func getColor(colorName: String) -> UIColor {
        let hexcode = helperVar.colors[colorName]
        return UIColor.init(netHex: hexcode ?? 0x000000)
    }
    
    
}
