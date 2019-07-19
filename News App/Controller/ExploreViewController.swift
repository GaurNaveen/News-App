//
//  ExploreViewController.swift
//  News App
//
//  Created by Naveen Gaur on 14/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
class ExploreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var categories = ["Sports","Business","Science","Technology"]
    var headlines: News? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .black
        tableView.backgroundColor = UIColor.init(netHex: 0xDDDDDD)
        view.backgroundColor = UIColor.init(netHex: 0xDDDDDD)
    }
}

extension ExploreViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExploreView else {
            fatalError("Could not dequeue cell with identifier: cell --HI")
        }
        print("Hello")
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.getNews(country: "us", category: categories[indexPath.row])) { (result) in
            switch result{
                
            case .success(let response):
                if response.statusCode == 200 {
                    // Parse JSON Response
                    self.headlines = try! JSONDecoder().decode(News.self, from: response.data)
                    cell.setNews(headlines: self.headlines!)
                    cell.reloadCollectionView()
                }
            case .failure(_):
                print("message")
            }
        }
        cell.setupCategoryLabel(indexPath: indexPath)
        cell.backgroundColor = UIColor.init(netHex: 0xDDDDDD)
        return cell
    }
}
