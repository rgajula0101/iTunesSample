//
//  ContactViewModel.swift
//  itunesSample
//
//  Created by Rakesh Kumar on 04/16/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import Foundation
import UIKit


class DashboardViewModel {

    var searchResult : SearchResult?

    public func getItunesWithSearchTerm(_ searchTerm: String,
                           parentViewController: UIViewController,
                           completionBlock:@escaping (Bool,String?) -> ()) {
        let baseURL = "https://itunes.apple.com/search?term=\(searchTerm)"
        SessionManager.sharedInstance.apiRequest(url: baseURL, method: HTTPMethodType.GET, parameter: nil, headers: nil, parentViewController: parentViewController, showProgress: true) { [weak self](success, response, errorMessage) in

            if success {
                if let responseData = response as? Data {
                    let decoder = JSONDecoder()

                    do {
                        let searchResult = try decoder.decode(SearchResult.self, from: responseData)
                        self?.searchResult = searchResult
                        completionBlock(success, errorMessage)
                        return


                    } catch {
                        print(error.localizedDescription)
                        completionBlock(success, error.localizedDescription)
                        return
                    }
                }
            }

            completionBlock(success, errorMessage)
        }

    }


}
