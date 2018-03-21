//
//  ApiClient.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import Foundation

class ApiClient {
    
    class func getData(completion: @escaping(Array<Any>)->()) {
        let urlString = "https://chex-triplebyte.herokuapp.com/api/cats?page=1"
        
        let urlConverted = URL(string: urlString)
        
        guard let url = urlConverted else {print("error in url"); return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { print("data nil"); return }
            
            let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as! Array<Any>
            
            guard let json = jsonDict else {print("json nil"); return }
            completion(json)
            
        }
        .resume()
        
    }
}