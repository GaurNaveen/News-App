//
//  FeatureService.swift
//  News App
//
//  Created by Naveen Gaur on 10/1/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import Foundation
import Moya

enum specificNewsService {
    case getNews(query: String)
}

extension specificNewsService: TargetType {
    var baseURL: URL {
        let url = URL(string: "https://newsapi.org")
        return url!
    }
    
    var path: String {
        switch self {
        case .getNews:
            return "/v2/everything"
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
        switch self {
        case .getNews(let query):
            return .requestParameters(parameters: ["q":query], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
         return ["X-Api-Key":"4eddeca93e8d4594bc9a605f7ef49319"]
    }
}
