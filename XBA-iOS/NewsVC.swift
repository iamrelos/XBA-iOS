//
//  NewsViewController.swift
//  XBA-iOS
//
//  Created by Christian Soler on 10/24/15.
//  Copyright © 2015 iamrelos. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var publishedLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorFirstNameLabel: UILabel!
    @IBOutlet weak var authorLastNameLabel: UILabel!
    
    var newsPermalink: String!
    var news: News!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.avatarImageView.layer.borderWidth = 3
        self.avatarImageView.layer.masksToBounds = false
        self.avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        self.avatarImageView.clipsToBounds = true
        
        RequestHandler.getNews(newsPermalink, completion: { (result) -> Void in
            self.news = result
            self.renderDisplay()
        })
    }
    
    @IBAction func openUrl(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: self.news.link!)!)
    }
    
    func renderDisplay(){
        self.authorFirstNameLabel.text = self.news.firstName
        self.authorLastNameLabel.text = self.news.lastName
        self.titleLabel.text = self.news.title
        self.publishedLabel.text = self.news.datePublished
        self.contentLabel.text = self.news.content

        RequestHandler.getImageFromUrl(self.news.avatar, completion: { (result) -> Void in
            self.avatarImageView.image = result
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "CommentsIdentifier" {
                let commentsVC = segue.destinationViewController as? CommentsTVC
                
                if (news != nil){
                    commentsVC!.nID = news.nID
                }
            }
        }
    }
}