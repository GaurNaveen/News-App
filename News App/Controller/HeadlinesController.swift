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
import SVProgressHUD
class HeadlinesController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private var count = 8 // intially count should be 0. After the news has been got , do reload.
    private var headlines: News? = nil // Holds the headlines fetched from the api.
    private var selectedIndex = 0
    
    // This is used to add pull to refreh the news headlines on the table view.
    private lazy var refresher: UIRefreshControl = {
       let refresherControl = UIRefreshControl()
        refresherControl.tintColor = .black
        refresherControl.addTarget(self, action: #selector(getHeadlines), for: .valueChanged)
        return refresherControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the delegate and datasource for the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .black // change the color for the separtor lines.
        getHeadlines() // call to the function that gets the headlines from the api.
        tableView.refreshControl = refresher // adds the pull to refresh to the table view.
        tableView.isHidden = true
    }
    
    // MARK: - Table view setup here.
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
    
    // MARK: - Provides animation on the table view cells.
    /// This function is called fraction of time before displaying the cells.It is being used to
    /// animate the table view cells.
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let animationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = animationTransform
        cell.alpha = 0
        UIView.animate(withDuration: 0.75) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
        
    }
    
    /// Function sets up the url for the clicked news article, so the WKWebview
    /// loads the right article.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? NewsViewController {
            nextVC.url1 = (headlines?.articles[selectedIndex].url)!
        }
    }
    
    // MARK: - Used to fetch the news headlines from the api.
    /// This function is used to fetch headlines/latest news from the api. After the news
    /// has been loaded it reloads the table view to update it with the latest data.
    @objc
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
                    self.tableView.isHidden = false
                    if self.refresher.isRefreshing {
                        self.refresher.endRefreshing()
                    }
                }
            case .failure(let error):
                // handle this error better.
                print("Here is the error \(error)")
            }
        }
    }
    
    
    /// This function is used to display a circular progress bar while news article that
    /// is selected the user is being loaded.
    ///
    /// - Parameter status: A string is passed which tells the function whether to show the
    ///                     progress bar or to dismiss it.
    func displayProgressCircle(status: String) {
        if status == "Show" {
            SVProgressHUD.show(withStatus: "Loading Article")
        } else {
            SVProgressHUD.dismiss()
        }
    }

}


