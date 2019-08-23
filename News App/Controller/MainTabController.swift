//
//  MainTabController.swift
//  News App
//
//  Created by Naveen Gaur on 31/12/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit
protocol TopOfTableView: class {
    func goToTop()
}
let key = "GoToTop"
class MainTabController: UITabBarController {
    
    var delegate2: TopOfTableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBOutlet weak var heaadlinesTab: UITabBar!
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            // Move to the top of the screen
           // print("tab bar item has been tapped")
            //self.delegate2?.goToTop()
        let name = Notification.Name(rawValue: key)
        NotificationCenter.default.post(name: name, object: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
