//
//  redditList.swift
//  Alamofire
//
//  Created by james luo on 4/21/18.
//

import UIKit
import Kingfisher
import Firebase
import Alamofire
class redditList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.rowHeight = 600
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
        cell.buildCell(articleTitle: redditArticles[indexPath.row].title, articleImage: redditArticles[indexPath.row].image, subReddit: redditArticles[indexPath.row].subReddit)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: redditArticles[indexPath.row].link) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    @IBAction func reload(_ sender: UIButton) {
        redditArticles.removeAll()
        let ref = Database.database().reference()
        ref.child("User").observeSingleEvent(of: .value, with: {snapShot in
            // Get user value
            let userArray = snapShot.value as! NSArray
            if (GlobaluserID >= userArray.count){
                return
            }
            let foundUser = userArray[GlobaluserID] as! NSDictionary
            let foundUrl = foundUser.value(forKey: "permaLinks") as! NSArray
            for url in foundUrl{
                Alamofire.request(url as! String)
                    .responseJSON { response in
                        //print(response)
                        //to get status code
                        //                    if let status = response.response?.statusCode {
                        //                        switch(status){
                        //                        case 201:
                        //                            print("example success")
                        //                        default:
                        //                            print("error with response status: \(status)")
                        //                        }
                        //                    }
                        //to get JSON return value
                        if let result = response.result.value {
                            let JSON = result as! NSArray
                            let newArticle = RedditArticle(passInJson: JSON)
                            redditArticles.append(newArticle)
                            
                        }
                        if redditArticles.count == foundUrl.count{
                            self.tableView.reloadData()
                        }
                        
                    }.resume()
            }
        }
        )
        
        
    }
    

}
