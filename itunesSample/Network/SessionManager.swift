//
//  SessionManager.swift
//  itunesSample
//
//  Created by Rakesh Kumar on 04/16/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration


typealias APIResult = (Bool,Any?,String?) -> ()

enum HTTPMethodType:Int {
    case GET = 1
    case POST = 2
    case PUT = 3
    case DELETE = 4
}

class SessionManager: NSObject {
    
    
    //MARK: - Properties
    
    static var sharedInstance = SessionManager()
    
    private override init() {
        
    }

    lazy var defaultSession:URLSession = {

        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type":"application/json; charset=UTF-8"]
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)

    }()
    
    private func connectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    

    
    //MARK: - Public Methods

    public func apiRequest(url:String, method: HTTPMethodType, parameter: [String:Any]?, headers:[String:Any]?, parentViewController: UIViewController, showProgress: Bool, completion:@escaping APIResult) {
        
        //Check if internet is available
        if !self.connectedToNetwork() {
            completion(false, nil, Message.InternetNotAvailable)
            return
        }
        if showProgress {
            DispatchQueue.main.async {
                MBProgressIndicator.hideIndicator(parentViewController.view)
                MBProgressIndicator.showIndicator(parentViewController.view)
                
            }
            
        }
        
        var httpMethodValue: String!
        switch method {
        case HTTPMethodType.GET:
            httpMethodValue = "GET"
            break
        case HTTPMethodType.POST:
            httpMethodValue = "POST"
            break
        case HTTPMethodType.PUT:
            httpMethodValue = "PUT"
            break
        case HTTPMethodType.DELETE:
            httpMethodValue = "DELETE"
            break
        }

        guard let url = URL(string: url) else {
            completion(false, nil, Message.FetchingDataError)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethodValue

        let task = defaultSession.dataTask(with: urlRequest, completionHandler: { (data,response,error) in

            DispatchQueue.main.async {
                MBProgressIndicator.hideIndicator(parentViewController.view)
            }
            if let urlResponse = response as? HTTPURLResponse,
                (200..<300).contains(urlResponse.statusCode) {
                completion(true, data, "")

            } else {
                completion(false, nil, Message.FetchingDataError)
            }



        })
        task.resume()
        
        
    }
    
    
}

