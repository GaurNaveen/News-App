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
    }
    
    /// This function is used to set the title for the navigation bar.
    private func setupNavBar() {
        navigationBar.dropShadow(scale: true)
        navigationBar.topItem?.title = "News Topic"
    }
    
    private func setupNewsTopicArray() {
        newsTopics = ["Fashion","NBA","NFL","Soccer","Music"]
    }
    
}

// MARK: - Setup for table view here.
extension NewsTopicController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTopics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewsTopicsCell else {
            fatalError("Could not dequeue cell with identifier: cell")
        }
        return cell
    }
    
}
