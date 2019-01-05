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
    private var headlines: News? = nil // Holds the headlines fetched from the api.
    private var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the delegate and datasource for the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .black // change the color for the separtor lines.
        getHeadlines() // call to the function that gets the headlines from the api.
    }
    
    /// This function defines how many rows there will be in the table view depending
    /// on the articles.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines?.articles.count ?? 0
    }
    
    /// This function is used to setup table view cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the reference of the cell through the reusable identifier.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as?HeadlinesCell
            else {
                fatalError("Could not dequeue cell with identifier: cell")
        }
        // setup each cell with the news.
        cell.displayNews(news: headlines, indexPath: indexPath)
        return cell
    }
    
    /// When the user selects a cell , the app takes the user to a new view where the
    /// user can view the article in it's full capacity.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "headlinesTodashboard", sender: self)
    }
    
    /// Function sets up the url for the clicked news article, so the WKWebview
    /// loads the right article.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? NewsViewController {
            nextVC.url1 = (headlines?.articles[selectedIndex].url)!
        }
    }
    
    /// This function is used to fetch headlines/latest news from the api. After the news
    /// has been loaded it reloads the table view to update it with the latest data.
    func getHeadlines() {
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.getNews(country: "us", category: "science")) { (result) in
            switch result {
            case .success(let response):
                // If the api request has been successful , then set the headlines object
                // with the data loaded and reload the table view.
                if response.statusCode == 200 {
                    self.headlines = try? JSONDecoder().decode(News.self, from: response.data)
                    self.tableView.reloadData()
                }
            case .failure(let error):
                // handle this error better.
                print("Here is the error \(error)")
            }
        }
    }
    
}


