//
//  NewsService.swift
//  News App
//
//  Created by Naveen Gaur on 22/12/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation
import Moya


enum NewsService {
    case getNews(country: String,category: String)
    case wsj(domain: String)
    case region(country: String)
    case search(query: String)
}

extension NewsService: TargetType {
    
    var baseURL: URL {
        let url = URL(string: "https://newsapi.org")
        return url!
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/v2/top-headlines"
        case .wsj:
            return"/v2/everything"
        case .region:
            return "/v2/top-headlines"
        case .search:
            return "/v2/everything"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        case .wsj:
            return .get
            
        case .region:
            return .get
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch  self {
        case .getNews(let country,let category):
            return .requestParameters(parameters: ["country":country,"category":category], encoding: URLEncoding.default)
        case .wsj(let domain):
            return .requestParameters(parameters: ["domains":domain], encoding: URLEncoding.default)
        case .region(let country):
            return .requestParameters(parameters: ["country":country], encoding: URLEncoding.default)

        case .search(let query):
            return .requestParameters(parameters: ["q":query,"from":"2019-07-20","sortBy":"publishedAt","language":"en"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["X-Api-Key":"4eddeca93e8d4594bc9a605f7ef49319"]
    }
}
