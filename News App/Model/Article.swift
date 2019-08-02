//
//  Article.swift
//  News App
//
//  Created by Naveen Gaur on 23/12/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation

/// Holds the News Article information like author, url to news article etc.
struct Article: Decodable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?    // This is the date on which the article was published.
    let content: String?
}


