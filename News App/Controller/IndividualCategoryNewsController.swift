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
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .black
    }
    
    func setupHeading() {
        categoryType.text = category+" News"
    }
}

extension IndividualCategoryNewsController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  news?.articles.count ?? 0
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? IndividualCell else {
            fatalError("Couldn't deque cell with identifier cell")
        }
        cell.setupCell(news: news!, row: indexPath.row)
        return cell
    }
}
