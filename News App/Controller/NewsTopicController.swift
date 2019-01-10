//
//  NewsTopicController.swift
//  News App
//
//  Created by Naveen Gaur on 8/1/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class NewsTopicController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    private var newsTopics = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavBar()
        setupNewsTopicArray()
        tableView.separatorStyle = .none
    }
    
    /// This function is used to set the title for the navigation bar.
    private func setupNavBar() {
        navigationBar.dropShadow(scale: true)
        navigationBar.topItem?.title = "News Topic"
    }
    
    // MARK: - Here are the News Topic names.
    /// Fills the array with the hardcoded news topic.
    private func setupNewsTopicArray() {
        newsTopics = ["Fashion","NBA","NFL","Soccer","Music"]
    }
    
}

// MARK: - Setup for table view here.
extension NewsTopicController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We make the count half because we have two views that will display the
        // topic name on each cell.
        return newsTopics.count/2
    }
    
    /// This function is used to setup the table view cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewsTopicsCell else {
            fatalError("Could not dequeue cell with identifier: cell")
        }
        cell.setupSelectionViews()
        cell.setSelectionViewNames(topicName: newsTopics)
        return cell
    }
    
    // MARK: - Add animations on the table view cells.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = animationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
}
