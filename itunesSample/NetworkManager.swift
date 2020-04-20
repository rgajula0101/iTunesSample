//
//  NetworkManager.swift
//  iTunes_Search_App
//
//  Created by Rakesh Kumar on 4/15/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import UIKit

public class NetworkManager {
    
    class func fetchData(searchTerm: String, completion: @escaping (Result<SearchResult, NetworkError>)->()) {
        
        let baseURL = "https://itunes.apple.com/search?term=\(searchTerm)"
        guard let url = URL(string: baseURL) else { return }

        let request = URLRequest(url: url)

        let session = URLSession(configuration: URLSessionConfiguration.default)
        print("THIS LINE IS PRINTED")
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            guard let data = data else {
                completion(.failure(NetworkError.badConnection))
                return
            }

            do {
                let decoder = JSONDecoder()
                let employees = try decoder.decode(SearchResult.self, from: data)
                completion(.success(employees))
            } catch let error {
                completion(.failure(NetworkError.decodingFailure))
                print("Error serialization json", error)
            }
        })
        task.resume()
        

    }
}

public enum NetworkError: Error {
    case badConnection
    case decodingFailure
}
