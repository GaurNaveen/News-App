//
//  NewsTopicController.swift
//  News App
//
//  This file setsup the view that will display
//  the news topic names on the table view cell.
//
//  Created by Naveen Gaur on 8/1/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
public var globalIndex = 0
class NewsTopicController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    private var newsTopics = [String]()
    var tapGesture = UITapGestureRecognizer()
    private var indexCount: Int = 0 // This control the index for the views inside the table view cells.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavBar()
        setupNewsTopicArray()
        getParticularNews(newsTopic: "premier league")
        configureTableView()
        view.isUserInteractionEnabled = true
        tableView.isUserInteractionEnabled = true
    }
    
    /// This function is used to configure some properties of the table view.
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    /// This function is used to set the title for the navigation bar.
    private func setupNavBar() {
        navigationBar.dropShadow(scale: true)
        navigationBar.topItem?.title = "News Topic"
    }
    
    // MARK: - Here are the News Topic names.
    /// Fills the array with the hardcoded news topic.
    private func setupNewsTopicArray() {
        newsTopics = ["Fashion","NBA","NFL","Soccer","Music","Premier League","Politics","Technology","Apple","Microsoft"]
    }
    
    // MARK: - This function is used to connect to the api and get the data from it.
    /// This function is used to get data from the api about a particular news topic that a user
    /// might select.
    ///
    /// - Parameter newsTopic: Takes a string as a parameter that indicates what news topic the
    ///             user might be intrested in.
    func getParticularNews(newsTopic: String) {
        let newsService = MoyaProvider<specificNewsService>()
        newsService.request(.getNews(query: newsTopic), completion: { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    // Parse JSON Response
                    let json = try! JSONDecoder().decode(News.self, from: response.data)
                }
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    /// This Function is triggered when the user taps on a cell that displayed the news topic to them.
    ///
    /// - Parameter _ges: Takes in a UIGestureRecognizer as a param.
    @objc
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        if (gestureRecognizer.view as? UILabel) != nil {
        }
    }
}

// MARK: - Setup for table view here.
extension NewsTopicController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We make the count half because we have two views that will display the
        // topic name on each cell.
        return newsTopics.count/2
    }
    
    //  MARK:- The Tap gesture is configured here.
    /// This function is used to setup the table view cells.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? NewsTopicsCell else {
            fatalError("Could not dequeue cell with identifier: cell")
        }
        
        cell.setupSelectionViews()
        cell.setSelectionViewNames(topicName1: newsTopics[indexCount], topicName2: newsTopics[indexCount+1])
        indexCount+=2 // Increment the index count after each cell has been setup.
        
        // Setup the tap gesture here.
        tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleTap(gestureRecognizer:)))
        cell.addGestureRecognizer(_ges: tapGesture)
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
