//
//  MyTableViewController.swift
//  CatApi
//
//  Created by Emiko Clark on 3/20/18.
//  Copyright © 2018 Emiko Clark. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    let catds = CatDataStore()
    let imageFromCache = UIImage()
    let imageCache = NSCache<NSString, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        catds.getCatData { (CatArray) in
            print(CatArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catds.Cats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        let urlString = catds.Cats[indexPath.row].image_url
        
        let url = URL(string: urlString!)
        
        cell.catImage.image = #imageLiteral(resourceName: "placeholder")
        cell.title.text = catds.Cats[indexPath.row].title
        cell.catDescription.text = catds.Cats[indexPath.row].catDescription
        
        // get catImage async
        if let img = imageCache.object(forKey: NSString(string: urlString!)!) != nil {
            cell.catImage.image = img
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error ?? "Error with downloading catImage")
                return
            }
            
            guard let data = data else { print("data nil"); return }
        
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data)
                self.imageCache.setObject(imageToCache!, forKey: NSString.init(string: urlString!))
                cell.catImage.image = imageToCache
            }
        }.resume()
        
        return cell
    }
    
    
    
    
    func getImageData(url: URL, completion: @escaping(UIImage)->()) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { print("data nil"); return }
            let imageData = UIImage(data: data)
            completion(imageData!)
            }.resume()
    }
    
}

//let imageCache = NSCache()

//extension UIImageView {
//    let imageCache = NSCache()
//
//    func loadImageUsingString(urlString: String) {
//        let url = URL(string: urlString)
//        image = nil
//
//        // check cache
//        if let imageToCache = imageFromCache.objectForKey(urlString) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//
//        // download if not in cache
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//
//            if error != nil {
//                print(error)
//                return
//            }
//
//            DispatchQueue.main.async {
//                imageToCache = UIImage(data: data!)
//
//                //add image to cache
//                imageCache.setObject(imageToCache)
//            }
//        }).resume()
//    }
//}

//------------
//if (self.imageCache.object(forKey: (indexPath as NSIndexPath).row as URL) != nil){
//    // 2
//    // Use cache
//    print("Cached image used, no need to download it")
//    cell.catImage?.image = self.imageCache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
//}else{
//// 3

//URLSession.shared.downloadTask(with: url!, completionHandler: { (location, response, error) -> Void in
//    if let data = try? Data(contentsOf: url!){
//        // 4
//        DispatchQueue.main.async(execute: { () -> Void in
//            // 5
//            // Before we assign the image, check whether the current cell is visible
//            if let updateCell = tableView.cellForRow(at: indexPath) {
//                let img:UIImage! = UIImage(data: data)
//                cell.catImage.image = img
//                self.imageCache.setObject(img, forKey: (indexPath as NSIndexPath).row as UIImage)
//            }
//        })
//    }
//}).resume()

// --------
    
    //
    //        let cacheKey = indexPath.row
    //
    //        if(self.imageCache.object(forKey: String(cacheKey) as NSString) != nil){
    //            cell.catImage.image = self.imageCache.object(forKey: String(cacheKey) as NSString) as? UIImage
    //        }else{
    //            DispatchQueue.main.async {
    //                if let url = URL(string: String(describing: url)) {
    //                    if let data = NSData(contentsOfURL: String(describing: url)) {
    //                        let image: UIImage = UIImage(data: data)!
    //                        self.imageCache.setObject(image, forKey: cacheKey)
    //                        dispatch_async(dispatch_get_main_queue(), {
    //                            cell.img.image = image
    //                        })
    //                    }
    //                }
    //            })
//}



//
//        // download images async
//        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//
//            if error != nil {
//                print(error!)
//                return
//            }
//
//            DispatchQueue.main.async(execute: { () -> Void in
//                guard let image = UIImage(data: data!) else { print("data to uiimage conversion failed"); return }
//                cell.catImage.image = image
//            })
//        }).resume()

//---------------------

//let cache = NSCache<CustomKey, UIImage>()

//final class CustomKey : NSObject {
//
//    let int: Int
//    let string: String
//
//    init(int: Int, string: String) {
//        self.int = int
//        self.string = string
//    }
//
//    override func isEqual(_ object: Any?) -> Bool {
//        guard let other = object as? CustomKey else {
//            return false
//        }
//        return int == other.int && string == other.string
//    }
//
//    override var hash: Int {
//        return int.hashValue ^ string.hashValue
//    }
//
//}

