//
//  News.swift
//  News App
//
//  Created by Naveen Gaur on 23/12/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation

/// Holds the response from the server
struct News: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
