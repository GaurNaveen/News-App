//
//  ExploreView.swift
//  News App
//
//  Created by Naveen Gaur on 14/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya

class ExploreView: UITableViewCell {
    var row: Int = 0
    var headlines:News? = nil
    
    var load: Bool = false
    var category = ["Sports","Business","Science","Technology"]
    
    @IBOutlet weak var categoryType: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.init(netHex: 0xDDDDDD)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected stated
    }
    
    func setNews(headlines: News) {
        self.headlines = headlines
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func setupCategoryLabel(indexPath: IndexPath) {
        categoryType.text = category[indexPath.row]
    }
}

extension ExploreView: UICollectionViewDataSource,UICollectionViewDelegate {
    // This has to return 1.It's fixed.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError("Could not deque cell with identifier: cell")
        }
        if headlines != nil {
            cell.setNews(headlines: self.headlines!,row:indexPath.row)
              cell.contentView.layer.borderWidth = 0.1
            cell.contentView.layer.cornerRadius = 5
        }
                    return cell
    }
}
