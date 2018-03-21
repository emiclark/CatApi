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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return catds.Cats.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        let url = URL(string: catds.Cats[indexPath.row].image_url!)
        catds.downloadImages(url: url, completion: { (catDataImage) in
            
            DispatchQueue.main.async {
                cell.catImage.image = UIImage(data: Data)
                self.tableView.reloadData()
            }
        })
    
        cell.title.text = catds.Cats[indexPath.row].title
        cell.catDescription.text = catds.Cats[indexPath.row].catDescription
        return cell
    }
}
