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
    
 let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_gestureRecognizer:)))
    
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
        //addGestureRecognizerToViews()
    }
    
    // MARK: - This function is used to add gesture recognizer on the views that holds the news topic.
    func addGestureRecognizer(_ges: UIGestureRecognizer) {
        // Tap Gesture for the second view. You cannot use one gesture for two views.
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_gestureRecognizer:)))
        // Add the gesture for the first label.
        topicLabel1.addGestureRecognizer(_ges)
        topicLabel1.isUserInteractionEnabled = true
        
        // add the gesture to the second label.
        topicLabel2.addGestureRecognizer(tapgesture)
        topicLabel2.isUserInteractionEnabled = true
    }
    
    /// This function is used to set the text on the labes that will display the news
    /// topic names.
    ///
    /// - Parameters:
    ///   - topicName1: A String that indicated a news topic name.
    ///   - topicName2: A String that indicates a news topic names.
    func setSelectionViewNames(topicName1: String, topicName2: String) {
        // Add the two label created programmatically to the two views.
        topicSelectionView1.addSubview(topicLabel1)
        topicSelectionView2.addSubview(topicLabel2)
        setAutoLayoutOnLabels() // set auto layout on these labels.
        // Set the topic names.
        topicLabel1.text = topicName1
        topicLabel2.text = topicName2
    }
    
    /// This function is used to set constraints on the labels created programmatically.
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

    // MARK: - This function handles what happens after the view is tapped.
    /// When the user taps on the view it will take them to a new view where they will be able to
    /// see news particular to the topic they chose.
    @objc
    func handleTap(_gestureRecognizer: UIGestureRecognizer) {
        // Handle what happens after the view is tapped.
        print("YOOP")
    }
    
}
