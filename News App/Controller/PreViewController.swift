//
//  PreViewController.swift
//  News App
//
//  This file basically checks if there are existing user settings.
//  If Yes, then it takes them directly to news. Else it takes the
//  user to the topic selection screen.
//
//  Created by Naveen Gaur on 22/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class PreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.checkForUserSettings()
        })
        
    }
    
    func checkForUserSettings() {
        let data = UserDefaults.standard
        
        guard let topics = data.array(forKey: "favtopics") as? [String] else {
            fatalError("Nah Mate its empty")
        }
       
        userSelectedTopics = topics
        
        if userSelectedTopics.isEmpty {
            print("Its empty")
            performSegue(withIdentifier: "toTopicSelection", sender: self)
        } else {
            performSegue(withIdentifier: "toMainDashboard", sender: self)
        }
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
