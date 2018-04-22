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
    init(passInJson: NSArray) {
        let objectID = (passInJson[0] as AnyObject).value(forKey: "data") as! NSDictionary
        let children = objectID.value(forKey: "children") as! NSArray
        let data = (children[0] as AnyObject).value(forKey: "data") as! NSDictionary
        title = (data.value(forKey: "title") as! NSString) as String
        self.image = data.value(forKey: "thumbnail") as! String
        
        //print(imageData)
        print(title)
    }
}
