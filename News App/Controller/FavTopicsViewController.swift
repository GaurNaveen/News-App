//
//  FavTopicsViewController.swift
//  News App
//
//  Created by Naveen Gaur on 17/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
import SVProgressHUD
class FavTopicsViewController: UIViewController {
    
    var favNews: News? = nil
    var sectionCount = 0
    var rowCount = 0
    
    /// Declare Table View Variable
    @IBOutlet weak var tableView: UITableView!
    
    /// Data Object for the Table View Sections.
    
    //This will contains the nodes that the user selects from the bubble topic selection.
    /// TODO: Put this var equal to userSelectedTopics global var.
    var sections: [String] = []
    var set = false
    
    //This will have the news object for each of the topic that the user selected.
    var sectionsData: [News] = []
    
    @objc func goToTop() {
        tableView.setContentOffset(.zero, animated: true)
    }
    
    let name = Notification.Name(rawValue: "GoToTop")
    func createObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToTop), name: name, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// TODO: Load the data first and then setup the table view.
       // setTableViewConstraints()
       // fetchSearchNews(searchQuery: "bitcoin")
        fetchNewsForFavTopics()
        createObserver()
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Loading News")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table View Instantiation
    
    /// Sets the delegate and data source for the table view.
    func setupTableView() {
        SVProgressHUD.dismiss()
        if set == false {
            tableView.separatorColor = .black
            tableView.delegate = self
            tableView.dataSource = self
            set = true
        } else {
            tableView.reloadData()
        }
    }
    
    /// This Function will fetch news for each topic the user is interested in and will keep on updating
    /// updating the table view as the news data comes.
    func fetchNewsForFavTopics() {
        for i in userSelectedTopics {
            /// TODO: load the news for each the topics selected by the user.Then
            /// keep updating the table view as the news come along.
            // This is an async , so the print statement will be executed well before and will return nil.
            let _ = fetchNews(favTopic: i)
            sectionCount+=1
        }
    }
    
    /// This Function is used to retrieve news for a particular topic.
    ///
    /// - Parameter favTopic: Takes the topic for which the news is required.
    /// - Returns: Returns the News
    func fetchNews(favTopic: String) -> News? {
        print("Fetch  news has been entered")
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.search(query: favTopic)) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    self.favNews = try? JSONDecoder().decode(News.self, from: response.data)
                    guard let news = self.favNews else {return}
                    self.updateTableViewWithData(favnews: news,topic: favTopic)
                } else {
                    print(response.statusCode)
                    self.checkForNetworkErrors(response: response)
                }
            case .failure(let error):
                print("Handle Error \(error) ")
            }
        }
        return favNews
    }
    
    /// This function basically handles the error that might arise during the fetching of news.
    /// It will call a func that will display an alert box to the user.
    ///
    /// - Parameter response: Takes the response from the server and handles the error codes accordingly.
    func checkForNetworkErrors(response: Response) {
        if response.statusCode == 500 {
            // error connecting to the server
        } else if response.statusCode == 429 {
            // Rate limit have been reached
        } else if response.statusCode == 400 {
            // Bad request. The request was unacceptable,often due to a missing or misconfigured param.
        } else {
            // Unknown Error.
        }
    }
    
    /// This is the function that will display the user an alert message
    /// when the news retrieval isn't
    ///
    /// - Parameter message: This is the message that will be displayed to the user.
    func presentAlert(message:String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        //self.present(alertController, animated: true, completion: nil)
        // Will have to do the protocol thing. Because this is not a UIView file it doesn't has any present function in it.
    }
    
    func updateTableViewWithData(favnews: News,topic: String) {
        // When you have the news update the table view with it.
            sections.append(topic)
            sectionsData.append(favnews)
            setupTableView()
    }
    
    // Before you segue send the data first.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? NewsViewController {
            nextVC.url1 = sectionsData[sectionCount].articles[rowCount].url!
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
        return sectionsData[section].articles.count
    }
    
    /// Setup for Table View Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? FavTopicsCell else {
            fatalError("Couldn't dequeue Resusable cell")
        }
        cell.setupNewsTitle(newsTitle: sectionsData[indexPath.section].articles[indexPath.row].title!)
        cell.loadImage(news: sectionsData[indexPath.section], indexPath: indexPath)
        return cell
    }
    
    /// This function specifies the height for each table view row.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
    
    /// This function is used to handle the size and font for the section header/title for the table view.
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.systemFont(ofSize: 28.0)
            header.textLabel!.textColor = UIColor.black
        }
    }
    
    /// This Function sets the height of the section header view in which the title is displayed.
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // When the user taps on the news , they will be taken to the web view where they can view the
    //  full news article.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sectionCount = indexPath.section
        rowCount = indexPath.row
        
        performSegue(withIdentifier: "favtopicsToDashboard", sender: self)
    }
}
