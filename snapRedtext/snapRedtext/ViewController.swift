//
//  ViewController.swift
//  snapRedtext
//
//  Created by james luo on 4/21/18.
//  Copyright © 2018 james luo. All rights reserved.
//

import UIKit
var GlobaluserID = 0
var redditArticles = [RedditArticle]()
class ViewController: UIViewController {

    
    @IBOutlet weak var UserID: UITextField!
    @IBAction func getUserID(_ sender: UITextField) {
        GlobaluserID = Int(UserID.text!)!
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let foundGlobalUser = UserDefaults.standard.object(forKey: "userID")as? Int {
            GlobaluserID = foundGlobalUser
            UserID.text = String(GlobaluserID)
        }
        //UserID.delegate = (self as! UITextFieldDelegate)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UserID.resignFirstResponder()
        if (UserID.text == "Enter User ID"){
            return
        }
        GlobaluserID = Int(UserID.text!)!
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadData(_ sender: UIButton) {
        UserDefaults.standard.set(GlobaluserID, forKey: "userID")
        //print(GlobaluserID)
    }
    
}

