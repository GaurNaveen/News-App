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
import Lottie

class PreViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var animationView: AnimationView!
    
    let creditWebsiteUrl = "https://newsapi.org"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startAnimation()
        setupCreditView()
        creditWebsite()
        
        /// This is IMP because if you just have the perform segue it won't work.
        /// As the view loads after some time and the func will be called before.
        /// So adding a delay here so the view loads fully.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            self.checkForUserSettings()
        })
    }
    
    func startAnimation() {
        animationView.animation = Animation.named("952-news")
        animationView.play()
    }
    
    /// This Function checks if a user has already selected some fav topics.
    /// if Yes, it will take them straight to headlines otherwise it will take them to
    /// the bubble topic selection screen.
    func checkForUserSettings() {
        let data = UserDefaults.standard
        
        if let topics = data.array(forKey: "favtopics") as? [String] {
            userSelectedTopics = topics
        }
       
        if userSelectedTopics.isEmpty {
            print("Its empty")
            performSegue(withIdentifier: "toTopicSelection", sender: self)
        } else {
            performSegue(withIdentifier: "toMainDashboard", sender: self)
        }
    }
    
    // MARK: - View to give credit to the news api data source.
    let creditView: UIButton =  {
        let view = UIButton()
        return view
    }()
    
    let creditLabel: UILabel =  {
        let label = UILabel()
        label.text = "News Powered by NewsApi.org"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textAlignment = .center
        return label
    }()
    
    func setupCreditView() {
        view.addSubview(creditView)
        
        // Setup AutoLayout
        creditView.translatesAutoresizingMaskIntoConstraints = false
        creditView.anchor(top: animationView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 50, left: 50, bottom: -150, right: -50))
        
        // Add the label to the view
        view.addSubview(creditLabel)
        creditLabel.translatesAutoresizingMaskIntoConstraints = false
        creditLabel.anchor(top: creditView.topAnchor, leading: creditView.leadingAnchor, bottom: creditView.bottomAnchor, trailing: creditView.trailingAnchor)
    }
    
    /// This function will take the user to the NewsApi.org website.
    /// This func adds the tap button functionality on the programmatically create button.
    func creditWebsite() {
        creditView.addTarget(self, action: #selector(PreViewController.coolFunc(_:)), for: .touchUpInside)
    }
    
    /// When the user taps on the button, it opens up the newsapi.org website.
    @IBAction func coolFunc(_ sender:UIButton!) {
        // do cool stuff here
        performSegue(withIdentifier: "toMainDash", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? NewsViewController {
            nextVC.url1 = creditWebsiteUrl
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
