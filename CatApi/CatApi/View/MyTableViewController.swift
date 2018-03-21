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
        
        let url = URL(string: catds.Cats[indexPath.row].image_url!)
        
        // download images async
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in

            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                cell.catImage.image = UIImage(data: data!)
            }
        }).resume()
    
        cell.title.text = catds.Cats[indexPath.row].title
        cell.catDescription.text = catds.Cats[indexPath.row].catDescription
        return cell
    }    
}
