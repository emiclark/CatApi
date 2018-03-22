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
    var continuousScrollIndexPath = 0
    var pageNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catds.delegate = self
        
//        catds.getCatData { (CatArray) in
//            print(CatArray)
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
        catds.getCatDataWithPageNum(pageNum: pageNum)
        DispatchQueue.main.async {
            self.tableView.reloadData()
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
        var urlImageString: String?
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        let urlString = catds.Cats[indexPath.row].image_url
        
        let url = URL(string: urlString!)
        urlImageString = urlString!
        
        cell.catImage.image = #imageLiteral(resourceName: "placeholder")
        cell.title.text = catds.Cats[indexPath.row].title
        cell.catDescription.text = catds.Cats[indexPath.row].catDescription
        
        // download cat image async
        if let img = imageCache.object(forKey: urlString! as NSString) {
            cell.catImage.image = img
        } else {
            URLSession.shared.dataTask(with: url!) { (data, response, error) in

                if error != nil {
                    print(error ?? "Error with downloading catImage")
                    return
                }

                guard let data = data else { print("data nil"); return }

                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    
                    // check to ensure get loaded into the correct cells
                    if urlImageString == urlString {
                        cell.catImage.image = imageToCache
                    }
                    self.imageCache.setObject(imageToCache!, forKey: urlString! as NSString)
                }
            }.resume()
        }
        return cell
    }
  
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if continuousScrollIndexPath != indexPath.row {
            continuousScrollIndexPath = indexPath.row
            let lastElement = self.catds.Cats.count - 3
            print("at row: \(indexPath.row), \(lastElement)")
            if indexPath.row == lastElement {
                print("Getting more cat images - pageNum:",pageNum,"\n")
                catds.getCatDataWithPageNum(pageNum: pageNum)
                print("got more cat images: page:\(self.pageNum)")
                self.pageNum += 1
            }
        } else {
            print("Same Index path was hit!!\n")
        }
    }
}

extension MyTableViewController : reloadCatDataDelegate {
    func UpdateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
