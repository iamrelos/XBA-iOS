//
//  NewsViewController.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/24/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var requestHandler = RequestHandler()
    var newsPermalink: String!
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.avatarImageView.layer.borderWidth = 3
        self.avatarImageView.layer.masksToBounds = false
//        self.avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        self.avatarImageView.clipsToBounds = true
        
        requestHandler.getNews(newsPermalink, completion: { (result) -> Void in
            self.news = result
            self.renderDisplay()
        })
    }
    
    func renderDisplay(){
//        self.titleLabel.text = self.news.title
//        self.authorLabel.text = self.news.author
//        self.publishedLabel.text = self.news.datePublished
//        self.contentLabel.text = self.news.content
//
        self.requestHandler.getImageFromUrl(self.news.avatar, completion: { (result) -> Void in
            self.avatarImageView.image = result
        })
        
//        self.requestHandler.getImageFromUrl(self.news.images[0], completion: { (result) -> Void in
//            self.newsImageView.image = result
//        })
    }
}