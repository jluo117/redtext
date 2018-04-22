//
//  redditList.swift
//  Alamofire
//
//  Created by james luo on 4/21/18.
//

import UIKit
import Kingfisher
class redditList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 600
        self.tableView.reloadData()
        print(redditArticles.count)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return redditArticles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RedditTread" , for: indexPath) as! redditTread
       cell.buildCell(articleTitle: redditArticles[indexPath.row].title, articleImage: redditArticles[indexPath.row].image)
        return cell
    }

}
