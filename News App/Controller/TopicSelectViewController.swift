//
//  TopicSelectViewController.swift
//  News App
//
//  Created by Naveen Gaur on 4/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Magnetic
class TopicSelectViewController: UIViewController {
    
    var userSelectedNodes: [String] = []

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
    }
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for _ in 0..<12 {
            add([])
        }
    }

}

// MARK: - MagneticDelegate
extension TopicSelectViewController: MagneticDelegate {
    
    /// This Function will help you identify which option was selected by the user.
    ///
    /// - Parameters:
    ///   - magnetic: magnetic object
    ///   - node: The category node.
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
        print(node.text ?? "none")
        userSelectedNodes.append(node.text ?? "none")
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
    }
}

