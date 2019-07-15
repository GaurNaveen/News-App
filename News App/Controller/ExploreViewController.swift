//
//  ExploreViewController.swift
//  News App
//
//  Created by Naveen Gaur on 14/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExploreView else {
            fatalError("Could not dequeue cell with identifier: cell --HI")
        }
        cell.backgroundColor = UIColor.init(netHex: 0xDDDDDD)
        return cell
    }
}
