//
//  TopicSelectViewController.swift
//  News App
//
//  Created by Naveen Gaur on 4/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Magnetic

var userSelectedTopics: [String] = []

class TopicSelectViewController: UIViewController {
    // This will hold the user selected topics.
     public var userSelectedNodes: [String] = []
    
     var getUserSelectedNodes: [String] {
        get {
            return userSelectedNodes
        }
    }

    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier:"moveToMainTabBar" , sender: self)
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    /// This is the setup for the view. It displays the bubbles the user can tap on.
    @IBOutlet weak var magneticView: MagneticView! {
        didSet {
            magnetic.magneticDelegate = self
            #if DEBUG
            magneticView.showsFPS = true
            magneticView.showsDrawCount = true
            magneticView.showsQuadCount = true
            #endif
        }
    }

    /// This is for th Add button. When the user taps on it , more bubbles are added.
    @IBAction func add(_ sender: Any) {
        
        let name = UIImage.names.randomItem()
        let color = UIColor.colors.randomItem()
        let node = Node(text: name.capitalized, image: UIImage(named: name), color: color, radius: 40)
        magnetic.addChild(node)
        
        // Image Node: image displayed by default
        // let node = ImageNode(text: name.capitalized, image: UIImage(named: name), color: color, radius: 40)
        // magnetic.addChild(node)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nextButton.alpha = 0
    
    }
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    /// When the view appears,initially 12 bubbles appear.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for _ in 0..<12 {
            add([])
        }
    }
    
    // MARK: - Move Forward
}

// MARK: - MagneticDelegate
extension TopicSelectViewController: MagneticDelegate {
    
    ///    This Function will help you identify which option was selected by the user.
    ///     This infomation will then be passed to the explore view controller.
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
        print(node.text ?? "none")
        userSelectedTopics.append(node.text ?? "none")
        
        if userSelectedTopics.count>1 {
            nextButton.alpha = 1
        }
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
    }
}
