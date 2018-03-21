//
//  CatDataStore.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import Foundation
import UIKit

class CatDataStore {
    
    var Cats = [Cat]()
    
    func getCatData(completion:@escaping([Cat])->()) {
        
        ApiClient.getData { (jsonArray) in
            for item in jsonArray {
                guard let catDictionary = item as? [String:Any] else {print("object failed"); return }
                let singleCat = Cat.init(json: catDictionary)
                self.Cats.append(singleCat)
            }
            completion(self.Cats)
        }
    }
    
    func downloadImages(url: URL, completion: @escaping(Data)->(UIImage)) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { print("data for image is nil"); return }
            let catImage: UIImage = UIImage(from: data)
            completion(catImage)
        }.resume()
    }
}

//-----

//            cell.catImage.image = UIImage(data: data)
//        }
//        if let data = try? Data(contentsOf: url!)
//        {

