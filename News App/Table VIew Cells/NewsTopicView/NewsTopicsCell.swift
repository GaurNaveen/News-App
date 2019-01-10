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
    
    /// This function is used to set the color of the views that holds the news topic names.
    func setupSelectionViews() {
        topicSelectionView1.backgroundColor = getColor(colorName: "customRed")
        topicSelectionView2.backgroundColor = getColor(colorName: "lightBlue")
    }
    
    /// This function takes a custom color name and the uses the Struct in the helper Group
    /// to get the hexcode for it and then returns UIColor for it.
    ///
    /// - Parameter colorName: Takes a string that describes a custom color name.
    /// - Returns: returns a UIColor for the custom color name. If it's not founc it returns the black color.
    func getColor(colorName: String) -> UIColor {
        let hexcode = helperVar.colors[colorName]
        return UIColor.init(netHex: hexcode ?? 0x000000)
    }
    
    
}
