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
    case getNews(country:String)
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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch  self {
        case .getNews(let country):
            return .requestParameters(parameters: ["country":country], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["X-Api-Key":"4eddeca93e8d4594bc9a605f7ef49319"]
    }
    
    
}
