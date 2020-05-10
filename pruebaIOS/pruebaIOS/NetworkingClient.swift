//
//  NetworkingClient.swift
//  pruebaIOS
//
//  Created by Camiilo on 09/05/2020.
//  Copyright © 2020 Camiilo. All rights reserved.
//

import Foundation
import Alamofire

class NetworkingClient{
    
    typealias responseService = ([[String: Any]]?, Error?) -> Void
    
    
    func execute(_ url: URL, completion: @escaping responseService) {
        
        var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
        
        
        Alamofire.request(urlRequest)
        
        Alamofire.request(url).validate().responseJSON {
            response in
            if let erorr = response.error {
                completion(nil, erorr)
            }else if let jsonArray = response.result.value as? [[String: Any]] {
                completion(jsonArray, nil)
            }else if let jsonDict = response.result.value as? [String: Any] {
                completion([jsonDict], nil)
            }
        }
    }
}
