//
//  ApiClient.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class ApiClient {
    static let imageCache = NSCache<NSString, UIImage>()

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

//    class func getImageData(url: URL, completion: @escaping(UIImage)->()) {
//        
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            
//            guard let data = data else { print("data nil"); return }
//            let imageData = UIImage(data: data)
//            completion(imageData!)
//            }.resume()
//    }

    
    
//    static func downloadImage(urlString: String, completion: @escaping (_ image: UIImage?) -> ()) {
//        guard let url = URL(string: urlString) else {print("error converting url"); return }
//
//        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
//            completion(cachedImage)
//        } else {
//            getImageData(url: url, completion: @escaping(UIImage)->(UIImage)) { data, response, error in
//                if let error = error {
//                    completion(nil, error)
//
//                } else if let data = data, let image = UIImage(data: data) {
//                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
//                    completion(image, nil)
//                } else {
//                    completion(nil, NSError.generalParsingError(domain: url.absoluteString))
//                }
//            }
//        }
//        }
//    }
}
