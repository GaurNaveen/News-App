//
//  ExploreViewController.swift
//  News App
//
//  Created by Naveen Gaur on 14/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya

class ExploreViewController: UIViewController,CollectionCellDelegate {

    func selectedItem(selectedNews: Article) {
        self.selectedNews = selectedNews
        performSegue(withIdentifier: "toDashboard2", sender: self)
        // let vc = storyboard!.instantiateViewController(withIdentifier: "next")
        // self.present(vc, animated: true, completion: nil)
    }
    
    var row = 0
    @IBOutlet weak var tableView: UITableView!
    var categories = ["Sports","Business","Science","Technology"]
    var selectedNews: Article? = nil
    var headlines: News? = nil
    var newsHold = [String:News]()
    var categoryIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .black
        tableView.backgroundColor = UIColor.init(netHex: 0xDDDDDD)
        view.backgroundColor = UIColor.init(netHex: 0xDDDDDD)
        tableView.keyboardDismissMode = .onDrag
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
        
        cell.delegate = self
        
        print("Hello,12")
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.getNews(country: "us", category: categories[indexPath.row])) { (result) in
            switch result{
                
            case .success(let response):
                if response.statusCode == 200 {
                    // Parse JSON Response
                    self.headlines = try! JSONDecoder().decode(News.self, from: response.data)
                    self.newsHold[self.categories[indexPath.row]] = self.headlines
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// This works like magic.
        row = indexPath.row
        print(row)
      performSegue(withIdentifier: "next", sender: self)
//        let vc = storyboard!.instantiateViewController(withIdentifier: "next")
//        self.present(vc, animated: true, completion: nil)
//        categoryIndex = indexPath.row
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? IndividualCategoryNewsController {
            nextVC.news = newsHold[categories[row]]
            nextVC.category = categories[row]
        }
        
        if let nextVC = segue.destination as? NewsViewController {
            nextVC.url1 = (selectedNews?.url)!
        }
    }
}
