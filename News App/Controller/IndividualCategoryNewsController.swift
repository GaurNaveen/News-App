//
//  IndividualCategoryNewsController.swift
//  News App
//
//  Created by Naveen Gaur on 19/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class IndividualCategoryNewsController: UIViewController {
    
    var news: News? = nil
    var category: String = ""
    var selectedIndex = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryType: UILabel!
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        setupHeading()
    }
    
    /// This function sets up the table view.
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .black
    }
    
    func setupHeading() {
        categoryType.text = category+" News"
    }
    
    /// Function sets up the url for the clicked news article, so the WKWebview
    /// loads the right article.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? NewsViewController {
            nextVC.url1 = (news?.articles[selectedIndex].url)!
        }
    }
}

extension IndividualCategoryNewsController: UITableViewDelegate,UITableViewDataSource {
    
    ///  This function determines the number of rows in the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  news?.articles.count ?? 0
        
    }
    
    /// This function handles the table view cell setup.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? IndividualCell else {
            fatalError("Couldn't deque cell with identifier cell")
        }
        cell.setupCell(news: news!, row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDashBoard", sender: self)
    }
}
