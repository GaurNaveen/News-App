//
//  FavTopicsViewController.swift
//  News App
//
//  Created by Naveen Gaur on 17/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class FavTopicsViewController: UIViewController {
    
    /// Declare Table View Variable
    private var tableView: UITableView!
    
    /// Data Object for the Table View Sections.
    
    //This will contains the nodes that the user selects from the bubble topic selection.
    /// TODO: Put this var equal to userSelectedTopics global var.
    let sections = ["Politics","Sports","TV"]
    
    
    //This will have the news object for each of the topic that the user selected.
    let sectionsData = [
        ["Hello","Bye"],
        ["Bye"],
        ["KK bye"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNewsForFavTopics()
        setTableViewConstraints()
    }
    
    // MARK: - Table View Instantiation
    
    /// Sets the delegate and data source for the table view.
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    /// This function defines the table view layout.
    func setTableViewConstraints() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(FavTopicsCell.self, forCellReuseIdentifier: "cell")
        
        setupTableView()
        
        self.view.addSubview(tableView) // Add the table view to the main view.
    }
    
    /// This Function will fetch news for each topic the user is interested in and will keep on updating
    /// updating the table view as the news data comes.
    func fetchNewsForFavTopics() {
        for i in sectionsData {
            /// TODO: load the news for each the topics selected by the user.Then
            /// keep updating the table view as the news come along.
        }
    }

}

// MARK: - Table View cell.
extension FavTopicsViewController: UITableViewDelegate,UITableViewDataSource {
    
    /// Determines the number of sections in the table view.
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    /// Determines the number of rows that will be there in the section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsData[section].count
    }
    
    /// Setup for Table View Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? FavTopicsCell else {
            fatalError("Couldn't dequeue Resusable cell")
        }
        return cell
    }
    
    /// This function specifies the height for each table view row.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
