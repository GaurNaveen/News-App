//
//  HeadlinesController.swift
//  News App
//
//  This File is used to configure the
//  heading tab of the tab controller.
//
//  Created by Naveen Gaur on 31/12/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import UIKit

class HeadlinesController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    private var count = 4 // intially count should be 0. After the news has been got , do reload.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the delegate and datasource for the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .black // change the color for the separtor lines.
    }
    
    /// This function defines how many rows there will be in the table view per section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    /// This function is used to setup table view cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the reference of the cell through the reusable identifier.
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HeadlinesCell
        else {
            fatalError("Could not dequeue cell with identifier: cell")
        }
        cell.getHealines(indexPath: indexPath) // pass the index path here.
        return cell
    }
    
    /// This function is used to fetch headlines/latest news.
    func getNews() {
        
    }
}


