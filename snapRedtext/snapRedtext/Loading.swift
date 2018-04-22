//
//  Loading.swift
//  snapRedtext
//
//  Created by james luo on 4/21/18.
//  Copyright © 2018 james luo. All rights reserved.
//

import UIKit
import Firebase
import Alamofire



class Loading: UIViewController {
    override func viewDidLoad() {
        loadSnaps()
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSnaps(){
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
                            self.performSegue(withIdentifier: "doneLoading", sender: self)
                        }
                        
                }.resume()
            }
        }
        )
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
