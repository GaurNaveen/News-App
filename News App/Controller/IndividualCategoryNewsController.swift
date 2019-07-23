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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryType: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = .black
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
        return cell
    }
}
