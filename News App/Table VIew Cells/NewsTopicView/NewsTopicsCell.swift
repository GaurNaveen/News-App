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
    
    // MARK: - Here are the two labels that will display the news topic name.
    var topicLabel1: UILabel =  {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textAlignment = .center
        return label
    }()
    
    var topicLabel2: UILabel =  {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "American Typewriter", size: 25)
        label.textAlignment = .center
        return label
    }()
    
    /// This function is used to set the color of the views that holds the news topic names.
    func setupSelectionViews() {
        topicSelectionView1.backgroundColor = getColor(colorName: "customRed")
        topicSelectionView2.backgroundColor = getColor(colorName: "lightBlue")
    }
    
    func setSelectionViewNames(topicName: [String]) {
        // Add the two label created programattically to the two views.
        topicSelectionView1.addSubview(topicLabel1)
        topicSelectionView2.addSubview(topicLabel2)
        setAutoLayoutOnLabels() // set auto layout on these labels.
        topicLabel1.text = "Hey"
        topicLabel2.text = "Hey"
    }
    
    func setAutoLayoutOnLabels() {
        topicLabel1.anchor(top: topicSelectionView1.topAnchor, leading: topicSelectionView1.leadingAnchor, bottom: topicSelectionView1.bottomAnchor, trailing: topicSelectionView1.trailingAnchor)
    
        topicLabel2.anchor(top: topicSelectionView2.topAnchor, leading: topicSelectionView2.leadingAnchor, bottom: topicSelectionView2.bottomAnchor, trailing: topicSelectionView2.trailingAnchor)
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
