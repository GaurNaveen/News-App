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

class HeadlinesController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,TopOfTableView {
    
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
    
    
    // MARK: - Notification and Observer pattern has been implemented here.
    /// Observer is implemented here. Notification comes from the MainTabController.
    @objc func goToTop() {
        tableView.setContentOffset(.zero, animated: true)
    }
    
    let name = Notification.Name(rawValue: "GoToTop")
    /// Important to call this function.
    func createObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToTop), name: name, object: nil)
    }
    // Need to remove the observer.
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        // Adds the loading indicator.
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Loading News")
        
        getHeadlines() // call to the function that gets the headlines from the api.
        createObserver()
    }
    
    /// This function is used to setup some of table view properties like
    /// delegate, datasource, refreshControl etc.
    func setupTableView() {
        // setup the delegate and datasource for the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .black // change the color for the separtor lines.
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
        
        if tableView.isScrollEnabled {
            // Don't do anything.
        } else {
            let animationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
            cell.layer.transform = animationTransform
            cell.alpha = 0
            UIView.animate(withDuration: 0.75) {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }
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
    fileprivate func newsLoaded() {
        // Reload the table view when the data is loaded.
         self.tableView.reloadData()
        SVProgressHUD.dismiss()
        // After the news is loaded ,dismiss the progress bar.
        self.tableView.isHidden = false
        // This is to stop the refreshing when the user pulls to refresh.
        if self.refresher.isRefreshing {
            self.refresher.endRefreshing()
        }
    }
    
    /// This function is used to fetch headlines/latest news from the api. After the news
    /// has been loaded it reloads the table view to update it with the latest data.
    @objc
    func getHeadlines() {
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.getNews(country: "us", category: "science")) { (result) in
            switch result {
            case .success(let response):
                print("Boom",response.statusCode)
                // If the api request has been successful , then set the headlines object
                // with the data loaded and reload the table view.
                if response.statusCode == 200 {
                    // Parse JSON Response
                    self.headlines = try? JSONDecoder().decode(News.self, from: response.data)
                    self.newsLoaded()
                } else if response.statusCode == 500 {
                    // Display an Alert Box Here
                    self.presentAlert(message: "There was an error connecting to the server")
                } else if response.statusCode == 429 {
                    fatalError("Rate Limit have been reached.")
                } else if response.statusCode == 400 {
                    fatalError("Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter.")
                } else {
                    SVProgressHUD.dismiss()
                }
                
            case .failure(let _):
                // handle this error better.
                SVProgressHUD.dismiss()
                self.presentAlert(message: "Network Error")
            }
        }
    }
    
    /// This is use to present an alert to the user indicating something went wrong while
    /// loading the news from the api.
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
//    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item.tag == 1 {
//            print("tab bar item tapped")
//        }
//    }
}
