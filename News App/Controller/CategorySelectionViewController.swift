//
//  CategorySelectionViewController.swift
//  News App
//
//  Created by Naveen Gaur on 24/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
class CategorySelectionViewController: UIViewController {
   
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        imageView.alpha = 0
        UIView.animate(withDuration: 3, delay: 1,  animations: {
            self.imageView.alpha = 1
            self.imageView.frame.origin.y -= 100
        }, completion: nil)
    }
}
