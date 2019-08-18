//
//  FavTopicsCell.swift
//  News App
//
//  Created by Naveen Gaur on 17/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit

class FavTopicsCell: UITableViewCell {

    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView() {
        addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = false
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = false
        cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = false
        cellView.rightAnchor.constraint(equalTo: rightAnchor, constant: 8).isActive = false
    }
}
