//
//  FetchNewsService.swift
//  News App
//
//  This File has the method that loads the data for each topic that
//  the user is interested in. The file is a core part of the
//  FavTopicViewController which shows user the news related to the topic of
//  their interests.
//
//  Created by Naveen Gaur on 18/8/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import Foundation
import Moya

final class FetchNews {
    
    var favNews: News? = nil
    
    /// This Function is used to retrieve news for a particular topic.
    ///
    /// - Parameter favTopic: Takes the topic for which the news is required.
    /// - Returns: Returns the News
    func fetchNews(favTopic: String) -> News? {
        let newsProvider = MoyaProvider<NewsService>()
        newsProvider.request(.search(query: favTopic)) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    self.favNews = try? JSONDecoder().decode(News.self, from: response.data)
                } else {
                    self.checkForNetworkErrors(response: response)
                }
            case .failure(let error):
                print("Handle Error \(error) ")
            }
        }
       return favNews
    }
    
    func checkForNetworkErrors(response: Response) {
        if response.statusCode == 500 {
            // error connecting to the server
        } else if response.statusCode == 429 {
            // Rate limit have been reached
        } else if response.statusCode == 400 {
            // Bad request. The request was unacceptable,often due to a missing or misconfigured param.
        } else {
            // Unknown Error.
        }
    }
    
}
