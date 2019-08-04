//
//  SearchViewContollerViewController.swift
//  News App
//
//  Created by Naveen Gaur on 9/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
import SVProgressHUD

class SearchViewController: UIViewController,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate {
    private var selectedIndex = 0
    var headlines:News? = nil
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // This is used to add pull to refreh the news headlines on the table view.
    private lazy var refresher1: UIRefreshControl = {
        let refresherControl = UIRefreshControl()
        refresherControl.tintColor = .black
       // refresherControl.addTarget(self, action: Selector("getNews"), for: .valueChanged)
        return refresherControl
    }()
    
    private lazy var refresher: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(fetchNews), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        searchBar.barTintColor = .black
        // Get user location to display below the search bar.
        //let currentUserLocation = NSLocale.current
        
        // Setup Table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .black
        fetchNewsForRegion(countryCode: "us")
        tableView.keyboardDismissMode = .onDrag
        tableView.refreshControl = refresher // adds the pull to refresh to the table view.
    }
    
    // TODO: When the user removes the text from the search bar then, change the news back to default.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
        }
    }
    
    @objc func getNews() {
    }
    
    
    /// This function is used to retrieve news from the API for a particular country.
    /// By default it is set to "US"
    ///
    /// - Parameter countryCode: The country code , for which the news is required.
    @objc func fetchNewsForRegion(countryCode: String) {
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.region(country: countryCode)) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    // Parse JSON Response
                    self.headlines = try! JSONDecoder().decode(News.self, from: response.data)
                    //TODO: Reload the table view data.
                    self.tableView.reloadData()
                    // This is to stop the refreshing when the user pulls to refresh.
                    if self.refresher.isRefreshing {
                        self.refresher.endRefreshing()
                    }
                }
                else {
                    print(response.statusCode)
                }
               
            case .failure(_):
                print("BOOM Here is the error")
            }
        }
    }
    
    /// This function is used to retrieve news from the API for a particular country.
    /// By default it is set to "US"
    ///
    /// - Parameter countryCode: The country code , for which the news is required.
    @objc func fetchNews() {
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.region(country: "us")) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    // Parse JSON Response
                    self.headlines = try! JSONDecoder().decode(News.self, from: response.data)
                    //TODO: Reload the table view data.
                    self.tableView.reloadData()
                    // This is to stop the refreshing when the user pulls to refresh.
                    if self.refresher.isRefreshing {
                        self.refresher.endRefreshing()
                    }
                }
                else {
                    print(response.statusCode)
                }
                
            case .failure(_):
                print("BOOM Here is the error")
            }
        }
    }
    
    
   
    /// This function checks for erroe status codes and provides
    /// appropiate description.
    ///
    /// - Parameter response: Response received from the API server.
    func networkErrorCheck(response:Response) {
        if response.statusCode == 429 {
            // Present the error for the below status code
            presentAlert(message: "Rate Limit has been reached.")
        } else if response.statusCode == 500 {
            presentAlert(message: "This was an error connecting to the server")
            
        } else if response.statusCode == 400 {
            presentAlert(message: "Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter.")
        }
    }
    
    /// Presents a pop up box with a messag.
    ///
    /// - Parameter message: The message that needs to be displayed. Could be an error.
    func presentAlert(message:String){
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        // Add the 'OK button'
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
    
    /// This function deciedes how many rows the table view should have.
    ///
    /// - Parameters:
    ///   - tableView: table view
    ///   - section: section
    /// - Returns: an integer depecting the number of row required.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines?.articles.count ?? 0
    }

    /// This function is used to setup the table view cell.
    /// It makes a call to the table view cell function that injects it with data  retrieved from the server.
    /// - Parameters:
    ///   - tableView: table view
    ///   - indexPath: index path
    /// - Returns: table view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchCell else {
            fatalError("Could not dequeue cell with identifier: cell")
        }
        cell.dropShadow()
        cell.diplayNews(news: headlines, indexPath: indexPath)
        return cell
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
    
    //TODO: When the user selects the row , take them to the webview. The webview has
    // already been creates so reuse that.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "trendingTonewsView", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? NewsViewController {
            nextVC.url1 = (headlines?.articles[selectedIndex].url)!
        }
    }
    
    // -- Search Bar Text used to get the data from the server -- //
    
    /// This function excutes when the user is done with typing the search query. This funtion will pass the searched text to
    ///  fetchNews(), which will retrieve the news for the searched  text.
    /// - Parameter searchBar: default
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            SVProgressHUD.show()
            fetchSearchNews(searchQuery: text)
            }
        }
    
    func fetchSearchNews(searchQuery:String){
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.search(query: searchQuery)) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    self.headlines = try? JSONDecoder().decode(News.self, from: response.data)
                    self.tableView.reloadData()
                     SVProgressHUD.dismiss()
                } else {
                    // TODO: Call the alert function and pass the error here.
                    print(response.data)
                }
                
            case .failure(_):
                // TODO: Handle failure.
                print("Error")
            }
        }
    }

//    override func viewWillAppear(_ animated: Bool) {
//        // This is done for dynamic height of table view rows.
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 296
//    }
}
