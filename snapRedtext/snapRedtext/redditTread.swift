//
//  redditTread.swift
//  Alamofire
//
//  Created by james luo on 4/21/18.
//

import UIKit
import Kingfisher
class redditTread: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func buildCell(articleTitle: String, articleImage: String)  {
        self.articleTitle.text = articleTitle
        print(articleImage)
        let articleImgUrl = URL(string: articleImage)
        self.articleImage.kf.setImage(with: articleImgUrl)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
