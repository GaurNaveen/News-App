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
import Moya
class HeadlinesController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    private var count = 8 // intially count should be 0. After the news has been got , do reload.
    
    var headlines: News? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the delegate and datasource for the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .black // change the color for the separtor lines.
        getHeadlines()
    }
    
    /// This function defines how many rows there will be in the table view depending
    /// on the articles.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines?.articles.count ?? 0
    }
    
    /// This function is used to setup table view cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the reference of the cell through the reusable identifier.
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HeadlinesCell
        else {
            fatalError("Could not dequeue cell with identifier: cell")
        }
        // setup each cell with the news.
        cell.displayNews(news: headlines, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "headlinesTodashboard", sender: self)
    }
    
    ///
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    /// This function is used to fetch headlines/latest news from the api.
    func getHeadlines() {
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.getNews(country: "us")) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    self.headlines = try? JSONDecoder().decode(News.self, from: response.data)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Here is the error \(error)")
            }
        }
    }
    
    
    
}


