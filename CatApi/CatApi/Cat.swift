//
//  Cat.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import Foundation

class Cat {
    
    var title: String?
    var image_url: String?
    var catDescription: String?
    
    init(json: [String:Any]) {
        guard let title = json["title"] as? String,
        let image_url = json["image_url"] as? String,
        let catDescription = json["description"] as? String
            else {print("error creating object"); return }
        
        self.title = title
        self.image_url = image_url
        self.catDescription = catDescription
    }
}


//    "title": "Keyboard Cat",
//    "timestamp": "2018-03-19T23:50:11Z",
//    "image_url": "https:\/\/triplebyte-cats.s3.amazonaws.com\/keyboard.jpg",
//    "description": "Play him off, keyboard cat!"
