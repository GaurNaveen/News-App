//
//  SearchViewContollerViewController.swift
//  News App
//
//  Created by Naveen Gaur on 9/7/19.
//  Copyright © 2019 Naveen Gaur. All rights reserved.
//

import UIKit
import Moya
import SVProgressHUD
class SearchViewController: UIViewController,UISearchBarDelegate {
    private var headlines: News?=nil
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchBar.delegate = self
        // Get user location to display below the search bar.
        let currentUserLocation = NSLocale.current
        print(currentUserLocation)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
    /// This function excutes when the user is done with typing the
    /// search query. This funtion will pass the searched text to
    /// fetchNews(), which will retrieve the news for the searched
    /// text.
    ///
    /// - Parameter searchBar: default
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text ?? "")
    }
    
    func fetchNewsForRegion(countryCode: String) {
        let newsProvider = MoyaProvider<NewsService>()
        
        newsProvider.request(.region(country: countryCode)) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    // Parse JSON Response
                    self.headlines = try? JSONDecoder().decode(News.self, from: response.data)
                    //TODO: Reload the table view data.
                    // self.tableView.reloadData()
                }
            case .failure(_):
                print("BOOM Here is the error")
            }
        }
    }
    
    
    /// This function gets the news for the searched text.
    ///
    /// - Parameter searchQuery: Country Code of the user.It is set to AUS by
    ///                           default.
    func fetchSearchNews(searchQuery:String){
        
    }
    
    func networkErrorCheck(response:Response) {
        if response.statusCode == 429 {
            // Present the error for the below status code
            presentAlert(message: "Rate Limit has been reached.")
        } else if response.statusCode == 500 {
            presentAlert(message: "This was an error connecting to the server")
            
        } else if response.statusCode == 400 {
            presentAlert(message: "Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter.")
        }
    }
    
    func presentAlert(message:String){
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        // Add the 'OK button'
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController,animated: true,completion: nil)
    }
}
