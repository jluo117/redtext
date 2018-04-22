//
//  RedditArticle.swift
//  snapRedtext
//
//  Created by james luo on 4/21/18.
//  Copyright © 2018 james luo. All rights reserved.
//

import Foundation
class RedditArticle {
    var image: String
    var title: String
    var link: String
    var subReddit: String
    init(passInJson: NSArray) {
        let objectID = (passInJson[0] as AnyObject).value(forKey: "data") as! NSDictionary
        let children = objectID.value(forKey: "children") as! NSArray
        let data = (children[0] as AnyObject).value(forKey: "data") as! NSDictionary
        title = (data.value(forKey: "title") as! NSString) as String
        self.image = data.value(forKey: "thumbnail") as! String
        self.link = "https://www.reddit.com/"
        self.link += data.value(forKey: "permalink")
            as! String
        self.subReddit = data.value(forKey: "subreddit_name_prefixed") as! String
        //print(imageData)
        print(title)
    }
}
